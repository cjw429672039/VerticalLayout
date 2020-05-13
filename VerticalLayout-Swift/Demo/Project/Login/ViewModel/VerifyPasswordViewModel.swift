//
//  VerifyPasswordViewModel.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

enum VerifyPasswordActionType {
    case none
    case faceIdSetting
    case touchIdSetting
    case changePassword
}

enum VerifyPasswordControllerAction: ViewControllerActionProtocol {
    case pop
    case changePassword(currentPwd: String)
}

class VerifyPasswordViewModel: VLBaseViewModel {
    private var passwordItem: TextInputItemViewModel?
    private var submitItem: ButtonItemViewModel?
    private var action: VerifyPasswordActionType?
    private var passwordErrorItem: TextItemViewModel?
    
    init(type: VerifyPasswordActionType) {
        self.action = type
        
        super.init()
    }
    
    override func signalTransform(input: VLBaseViewModel.SignalInput) -> VLBaseViewModel.SignalOutput {
        let passwordEnable = self.passwordItem!.textRelay.map {($0 ?? "").count >= 8}
        passwordEnable.bind(to: self.submitItem!.buttonEnableRelay).disposed(by: disposeBag)
        //错误信息显示
        Observable.combineLatest(passwordEnable, self.passwordItem!.textFieldEventRelay, self.passwordItem!.textRelay) {
            !$0 && ($1 == .editingDidEnd) && ($2 != nil && $2?.count != 0)
        }.bind(to: self.rx.showPasswordError()).disposed(by: disposeBag)
        //submit按钮点击
        self.submitItem?.action.bind(to: self.rx.submitRequest()).disposed(by: disposeBag)
        return super.signalTransform(input: input)
    }
    
    func showPasswordError(show: Bool, message: String? = nil) {
        switch show {
        case true:
            guard let index = self.items?[0].firstIndex(of: self.passwordItem!) else { return }
            guard self.items?[0].firstIndex(of: self.passwordErrorItem!) == nil else { return }
            self.passwordErrorItem?.update(errorHintText: message)
            self.items![0].insert(self.passwordErrorItem!, at: index + 1)
            self.tableViewAction.accept(.insertCell(indexPaths: [IndexPath(row: index + 1, section: 0)]))
            self.passwordItem?.errorStatus()
        case false:
            guard let index = self.items?[0].firstIndex(of: self.passwordErrorItem!) else { return }
            self.items?[0].remove(at: index)
            self.tableViewAction.accept(.deleteCell(indexPaths: [IndexPath(row: index, section: 0)]))
        }
    }
    
    func verifyPassword() {
        self.submitItem?.update(loading: true)
        self.tableViewAction.accept(.enable(status: false))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let  num = arc4random()
            switch num % 2 {
            case 0:
                self.handleSuccess()
            case 1:
                self.rx.showPasswordError(message: "Incorrect password").onNext(true)
            default:
                break
            }
            self.submitItem?.update(loading: false)
            self.tableViewAction.accept(.enable(status: true))
        }
    }
}

extension Reactive where Base: VerifyPasswordViewModel {
    func showPasswordError(message: String? = "Password must be at least 8 characters.") -> Binder<Bool> {
        return Binder(self.base, binding: { (viewModel, show) in
            viewModel.showPasswordError(show: show, message: message)
        })
    }

    func submitRequest() -> Binder<Void> {
        return Binder(self.base) { (viewModel, _) in
            viewModel.verifyPassword()
        }
    }
}

extension VerifyPasswordViewModel {
    private func handleSuccess() {
        switch self.action {
        case .faceIdSetting:
            self.viewControllerAction.accept(VerifyPasswordControllerAction.pop)
        case .touchIdSetting:
            self.viewControllerAction.accept(VerifyPasswordControllerAction.pop)
        case .changePassword:
            guard let password = self.passwordItem?.textRelay.value else { return }
            self.viewControllerAction.accept(VerifyPasswordControllerAction.changePassword(currentPwd: password))
        default:
            break
        }
    }
}

extension VerifyPasswordViewModel {
    //items配置以及其他数据配置(在init调用)
    override func configurateInstance() {
        super.configurateInstance()
        
        var verifyMsg = ""
        var verifyTitle = "Verify Password?"
        switch self.action {
        case .faceIdSetting:
            verifyMsg = "Verify your password to enable Face ID"
        case .touchIdSetting:
            verifyMsg = "Verify your password to enable Touch ID"
        case .changePassword:
            verifyMsg = "Enter current password to change password"
            verifyTitle = "Enter Current Password"
        default:
            verifyMsg = "Verify your password"
        }
        
        self.submitItem = ButtonItemViewModel(greenBGWhiteText: "Submit")
        self.passwordItem = TextInputItemViewModel(type: .password(), becomeFirst: true)
        self.passwordErrorItem = TextItemViewModel(errorHintText: "Incorrect password")

        self.items = [[EmptyItemViewModel(VLScaleHeight(20)),
                       TextItemViewModel(topTitle: verifyTitle),
                       EmptyItemViewModel(VLScaleHeight(12)),
                       TextItemViewModel(hintText: verifyMsg),
                       EmptyItemViewModel(VLScaleHeight(40)),
                       self.passwordItem!,
                       EmptyItemViewModel(VLScaleHeight(32)),
                       self.submitItem!]]
    }
}
