//
//  ChangePasswordViewModel.swift
//
//
//  Created
//  Copyright © . All rights reserved.
//

import UIKit
import RxSwift

enum ChangePasswordType {
    ///第一次登陆修改密码
    case firstLogin(email: String, currentPassword: String)
    ///输入当前密码修改密码
    case changePassword(currentPassword: String)
    ///验证邮箱修改密码
    case forgotPassword(email: String, code: String)
}

enum ChangePasswordControllerAction: ViewControllerActionProtocol {
    case webPage(title: String, urlString: String)
    case relogin
}

enum ChangePasswordAlertType: AlertViewActionProtocol {
    case resetSuccess
}

class ChangePasswordViewModel: VLBaseViewModel {
    private var titleItem: TextItemViewModel?
    private var newPasswordItem: TextInputItemViewModel?
    private var confirmPasswordItem: TextInputItemViewModel?
    private var submitItem: ButtonItemViewModel?
    private var confirmPasswordErrorItem: TextItemViewModel?
    private var termsAndPrivacyItem: AttributedTextViewItemViewModel?
    private var changePasswordType: ChangePasswordType
    
    init(type: ChangePasswordType) {
        self.changePasswordType = type
        
        super.init()
    }
    
    override func signalTransform(input: VLBaseViewModel.SignalInput) -> VLBaseViewModel.SignalOutput {
        //submit按钮enable
        let newPasswordEnable = self.newPasswordItem!.textRelay.map {($0 ?? "").isValidPassword()}
        let confirmPasswordEnable = self.confirmPasswordItem!.textRelay.map {($0 ?? "").isValidPassword()}
        Observable.combineLatest(newPasswordEnable, confirmPasswordEnable, self.newPasswordItem!.textRelay, self.confirmPasswordItem!.textRelay) {
            ($0 && $1 && ($2 == $3))
        }.bind(to: self.submitItem!.buttonEnableRelay).disposed(by: disposeBag)
        //submit按钮点击
        self.submitItem?.action.bind(to: self.rx.submitRequest()).disposed(by: disposeBag)
        Observable
            .combineLatest(newPasswordEnable,
                           confirmPasswordEnable,
                           self.newPasswordItem!.textRelay,
                           self.newPasswordItem!.textFieldEventRelay,
                           self.confirmPasswordItem!.textRelay,
                           self.confirmPasswordItem!.textFieldEventRelay)
            .subscribe(onNext: {[weak self] (newEnable, confirmEnable, newText, newEvent, confirmText, confirmEvent) in
                guard let self = self else { return }
                self.showPasswordError(newPasswordEnable: newEnable,
                                       confirmPasswordEnable: confirmEnable,
                                       newPassword: newText,
                                       newPasswordEvent: newEvent,
                                       confirmPassword: confirmText,
                                       confirmPasswordEvent: confirmEvent)
            }).disposed(by: disposeBag)
        self.termsAndPrivacyItem?.linkActionRelay.subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
            self.viewControllerAction.accept(ChangePasswordControllerAction.webPage(title: "Term",
                                                                                    urlString: "www.baidu.com"))
        }).disposed(by: disposeBag)
        
        return super.signalTransform(input: input)
    }
    
    override func handle(alertClick action: AlertViewActionProtocol) {
        super.handle(alertClick: action)
        
        switch action as? ChangePasswordAlertType {
        case .resetSuccess:
            self.viewControllerAction.accept(ChangePasswordControllerAction.relogin)
        default:
            break
        }
    }
    
    func resetPasswordNetworkRequest() {
        self.submitItem?.update(loading: true)
        self.tableViewAction.accept(.enable(status: false))
        switch self.changePasswordType {
        case .firstLogin:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.alertViewAction.accept(.single(title: "Password updated!",
                                                    msg: "You can now use your new password to log in to your account. ",
                                                    button: "OK",
                                                    color: VLHexColor(0x00C389),
                                                    action: ChangePasswordAlertType.resetSuccess))
                self.submitItem?.update(loading: false)
                self.tableViewAction.accept(.enable(status: true))
            }
        case .changePassword:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.alertViewAction.accept(.single(title: "Password updated!",
                                                    msg: "You can now use your new password to log in to your account. ",
                                                    button: "OK",
                                                    color: VLHexColor(0x00C389),
                                                    action: ChangePasswordAlertType.resetSuccess))
                self.submitItem?.update(loading: false)
                self.tableViewAction.accept(.enable(status: true))
            }
        case .forgotPassword:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.alertViewAction.accept(.single(title: "Password updated!",
                                                    msg: "You can now use your new password to log in to your account. ",
                                                    button: "OK",
                                                    color: VLHexColor(0x00C389),
                                                    action: ChangePasswordAlertType.resetSuccess))
                self.submitItem?.update(loading: false)
                self.tableViewAction.accept(.enable(status: true))
            }
        }
    }
    
    func showPasswordError(newPasswordEnable: Bool,
                           confirmPasswordEnable: Bool,
                           newPassword: String?,
                           newPasswordEvent: UIControl.Event,
                           confirmPassword: String?,
                           confirmPasswordEvent: UIControl.Event) {
        
        var message = "Your password must contain at least 8 characters, 1 number, 1 upper case letter and 1 lower case letter "
        var messageErrorStatus = false
        switch newPasswordEvent {
        case .editingDidEnd:
            switch newPasswordEnable {
            case false:
                if newPassword != nil && newPassword!.count != 0 {
                    self.newPasswordItem?.errorStatus()
                    messageErrorStatus = true
                }
            default:
                break
            }
        case .editingDidBegin:
            self.newPasswordItem?.normalStatus()
        default:
            break
        }
        
        switch confirmPasswordEvent {
        case .editingDidEnd:
            switch confirmPasswordEnable {
            case false:
                if confirmPassword != nil && confirmPassword!.count != 0 {
                    self.confirmPasswordItem?.errorStatus()
                    messageErrorStatus = true
                }
            default:
                break
            }
        case .editingDidBegin:
            self.confirmPasswordItem?.normalStatus()
        default:
            break
        }
        if newPasswordEnable && confirmPasswordEnable {
            if confirmPasswordEvent == .editingDidEnd && newPasswordEvent == .editingDidEnd {
                if newPassword != confirmPassword {
                    message = "The passwords you entered do not match"
                    self.newPasswordItem?.errorStatus()
                    self.confirmPasswordItem?.errorStatus()
                    messageErrorStatus = true
                }
            } else {
                self.newPasswordItem?.normalStatus()
                self.confirmPasswordItem?.normalStatus()
                messageErrorStatus = false
            }
        }
        
        if messageErrorStatus {
            self.confirmPasswordErrorItem?.update(errorHintText: message)
        } else {
            self.confirmPasswordErrorItem?.update(lightHintText: message)
        }
        guard let index = self.items?[0].firstIndex(of: self.confirmPasswordErrorItem!) else { return }
        self.tableViewAction.accept(.reloadCell(indexPaths: [IndexPath(row: index, section: 0)]))
    }
}

extension Reactive where Base: ChangePasswordViewModel {
    func submitRequest() -> Binder<Void> {
        return Binder(self.base) { (viewModel, _) in
            viewModel.resetPasswordNetworkRequest()
        }
    }
}

extension ChangePasswordViewModel {
    //items配置以及其他数据配置(在init调用)
    override func configurateInstance() {
        super.configurateInstance()
        
        self.titleItem = TextItemViewModel(topTitle: "Change Your Password")
        self.newPasswordItem = TextInputItemViewModel(type: .password(placeHolder: "New Password"))
        self.confirmPasswordItem = TextInputItemViewModel(type: .password(placeHolder: "Confirm Password"))
        self.confirmPasswordErrorItem = TextItemViewModel(lightHintText: "")
        self.submitItem = ButtonItemViewModel(greenBGWhiteText: "Change Password")
        self.termsAndPrivacyItem = AttributedTextViewItemViewModel(title: "By continuing, you agree to Arize’s Terms and Conditions and Privacy Policy.",
                                                                   linkTextItems: ["Terms and Conditions", "Privacy Policy"],
                                                                   linkURLItems: [URL(string: "www.baidu.com")!,
                                                                                  URL(string: "www.hao123.com")!],
                                                                   linkTextColor: VLHexColor(0x00C389),
                                                                   textAlignment: .left)
        self.items = [[EmptyItemViewModel(VLScaleHeight(20)),
                       self.titleItem!,
                       EmptyItemViewModel(VLScaleHeight(28)),
                       self.newPasswordItem!,
                       EmptyItemViewModel(VLScaleHeight(8)),
                       self.confirmPasswordItem!,
                       EmptyItemViewModel(VLScaleHeight(8)),
                       self.confirmPasswordErrorItem!,
                       EmptyItemViewModel(VLScaleHeight(32)),
                       self.submitItem!,
                       EmptyItemViewModel(VLScaleHeight(20)),
                       self.termsAndPrivacyItem!]]
        switch self.changePasswordType {
        case .firstLogin:
            self.titleItem?.update(text: "Create Your Own Password")
        case .changePassword:
            self.titleItem?.update(text: "Change Your Password")
            self.items![0].removeLast()
        case .forgotPassword:
            self.titleItem?.update(text: "Change Your Password")
            self.items![0].removeLast()
        }
    }
}
