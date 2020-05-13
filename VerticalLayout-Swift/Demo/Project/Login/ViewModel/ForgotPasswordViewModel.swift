//
//  ForgotPasswordViewModel.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

enum ForgotPasswordControllerAction: ViewControllerActionProtocol {
    case verifyEmail(email: String)
}

class ForgotPasswordViewModel: VLBaseViewModel {
    private var emailItem: TextInputItemViewModel?
    private var submitItem: ButtonItemViewModel?
    private var emailErrorItem: TextItemViewModel?
    init(email: String?) {
        super.init()
    
        self.emailItem?.update(text: email, becomeFirst: !(email ?? "").isEmail())
    }
    
    override func signalTransform(input: VLBaseViewModel.SignalInput) -> VLBaseViewModel.SignalOutput {
        //submit按钮enable
        let emailEnable = self.emailItem!.textRelay.map {($0 ?? "").isEmail()}
        emailEnable.bind(to: self.submitItem!.buttonEnableRelay).disposed(by: disposeBag)
        //email格式错误
        Observable.combineLatest(emailEnable, self.emailItem!.textFieldEventRelay, self.emailItem!.textRelay) {
            !$0 && ($1 == .editingDidEnd) && ($2 != nil && $2?.count != 0)
        }.bind(to: self.rx.showEmaiError()).disposed(by: disposeBag)
        //submit按钮点击
        self.submitItem?.action.bind(to: self.rx.submitRequest()).disposed(by: disposeBag)
        return super.signalTransform(input: input)
    }
    
    func submitVerifyEmail() {
        guard let email = self.emailItem?.textRelay.value else { return }
        self.submitItem?.update(loading: true)
        self.tableViewAction.accept(.enable(status: false))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let  num = arc4random()
            switch num % 4 {
            case 0:
                self.viewControllerAction.accept(ForgotPasswordControllerAction.verifyEmail(email: email))
            case 1:
                self.rx.showEmaiError(message: "This account does not exist").onNext(true)
            case 2:
                self.rx.showEmaiError(message: "The number of emails sent by the mailbox exceeds the limit of a single day").onNext(true)
            case 3:
                self.rx.showEmaiError(message: "Email format is incorrect").onNext(true)
            default:
                break
            }
            self.submitItem?.update(loading: false)
            self.tableViewAction.accept(.enable(status: true))
        }
    }
    
    func emailError(show: Bool, message: String? = nil) {
        switch show {
        case true:
            guard let index = self.items?[0].firstIndex(of: self.emailItem!) else { return }
            guard self.items?[0].firstIndex(of: self.emailErrorItem!) == nil else { return }
            self.emailErrorItem?.update(errorHintText: message)
            self.items![0].insert(self.emailErrorItem!, at: index + 1)
            self.tableViewAction.accept(.insertCell(indexPaths: [IndexPath(row: index + 1, section: 0)]))
            self.emailItem?.errorStatus()
        case false:
            guard let index = self.items?[0].firstIndex(of: self.emailErrorItem!) else { return }
            self.items?[0].remove(at: index)
            self.tableViewAction.accept(.deleteCell(indexPaths: [IndexPath(row: index, section: 0)]))
        }
    }
}

extension Reactive where Base: ForgotPasswordViewModel {
    func showEmaiError(message: String? = "Please enter a vaild email address") -> Binder<Bool> {
        return Binder(self.base, binding: { (viewModel, show) in
            viewModel.emailError(show: show, message: message)
        })
    }
    
    func submitRequest() -> Binder<Void> {
        return Binder(self.base) { (viewModel, _) in
            viewModel.submitVerifyEmail()
        }
    }
}

extension ForgotPasswordViewModel {
    //items配置以及其他数据配置(在init调用)
    override func configurateInstance() {
        super.configurateInstance()
        
        self.emailItem = TextInputItemViewModel(type: .email)
        self.submitItem = ButtonItemViewModel(greenBGWhiteText: "Submit", enable: false)
        self.emailErrorItem = TextItemViewModel(errorHintText: "")
        self.items = [[
            EmptyItemViewModel(20),
            TextItemViewModel(topTitle: "Forgot Your Password?"),
            EmptyItemViewModel(12),
            TextItemViewModel(hintText: "Enter your email and we'll help you out."),
            EmptyItemViewModel(40),
            self.emailItem!,
            EmptyItemViewModel(32),
            self.submitItem!
            ]]
    }
}
