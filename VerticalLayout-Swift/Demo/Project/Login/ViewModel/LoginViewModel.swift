//
//  LoginViewModel.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//
import RxSwift

enum LoginControllerAction: ViewControllerActionProtocol {
    case forgotPassword(email: String?)
    case resetPassword(email: String, password: String)
    case loginSuccess
}

class LoginViewModel: VLBaseViewModel {
    private var forgotPasswordItem: ButtonItemViewModel?
    private var logInItem: ButtonItemViewModel?
    private var emailItem: TextInputItemViewModel?
    private var passwordItem: TextInputItemViewModel?
    private var emailErrorItem: TextItemViewModel?
    private var passwordErrorItem: TextItemViewModel?
    
    override func signalTransform(input: VLBaseViewModel.SignalInput) -> VLBaseViewModel.SignalOutput {
        // 登录按钮enable信号
        let emailEnable = self.emailItem!.textRelay.map {($0 ?? "").isEmail()}
        let passwordEnable = self.passwordItem!.textRelay.map {($0 ?? "") .count >= 8}
        Observable.combineLatest(emailEnable, passwordEnable) {$0 && $1}.bind(to: self.logInItem!.buttonEnableRelay).disposed(by: disposeBag)
        //忘记按钮
        self.forgotPasswordItem?.action.map {
            LoginControllerAction.forgotPassword(email: self.emailItem?.textRelay.value)
        }.bind(to: self.viewControllerAction).disposed(by: disposeBag)
        //登录按钮
        self.logInItem?.action.bind(to: self.rx.loginRequest()).disposed(by: disposeBag)
        //email格式错误
        Observable.combineLatest(emailEnable, self.emailItem!.textFieldEventRelay, self.emailItem!.textRelay) {
            !$0 && ($1 == .editingDidEnd) && ($2 != nil && $2?.count != 0)
        }.bind(to: self.rx.showEmaiError()).disposed(by: disposeBag)
        //password格式错误
        Observable.combineLatest(passwordEnable, self.passwordItem!.textFieldEventRelay, self.passwordItem!.textRelay) {
            !$0 && ($1 == .editingDidEnd) && ($2 != nil && $2?.count != 0)
        }.bind(to: self.rx.showPasswordError()).disposed(by: disposeBag)
        return super.signalTransform(input: input)
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
    
    func passwordError(show: Bool, message: String? = nil) {
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
    
    func loginRequest() {
        self.logInItem?.update(loading: true)
        self.tableViewAction.accept(.enable(status: false))
        guard let email = self.emailItem?.textRelay.value, let password = self.passwordItem?.textRelay.value else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let  num = arc4random()
            switch num % 4 {
            case 0:
                UserDefaults.standard.set(email, forKey: "Email")
                self.viewControllerAction.accept(LoginControllerAction.loginSuccess)
            case 1:
                self.viewControllerAction.accept(LoginControllerAction.resetPassword(email: email, password: password))
            case 2:
                self.rx.showPasswordError(message: "Incorrect password").onNext(true)
            case 3:
                self.rx.showEmaiError(message: "This account does not exist").onNext(true)
            default:
                break
            }
            self.logInItem?.update(loading: false)
            self.tableViewAction.accept(.enable(status: true))
        }
    }
}

extension Reactive where Base: LoginViewModel {
    func showEmaiError(message: String? = "Please enter a vaild email address") -> Binder<Bool> {
        return Binder(self.base, binding: { (viewModel, show) in
            viewModel.emailError(show: show, message: message)
        })
    }
    
    func showPasswordError(message: String? = "Password must be at least 8 characters.") -> Binder<Bool> {
        return Binder(self.base, binding: { (viewModel, show) in
            viewModel.passwordError(show: show, message: message)
        })
    }
    
    func loginRequest() -> Binder<Void> {
        return Binder(self.base) { (viewModel, _) in
            viewModel.loginRequest()
        }
    }
}

extension LoginViewModel {
    //items配置以及其他数据配置(在init调用)
    override func configurateInstance() {
        super.configurateInstance()
        
        let email = (UserDefaults.standard.value(forKey: "Email") as? String) ?? ""
        let isEmail = email.isEmail()
        self.forgotPasswordItem = ButtonItemViewModel(onlyText: "Forgot password?")
        self.logInItem = ButtonItemViewModel(greenBGWhiteText: "Log in", enable: false)
        self.emailItem = TextInputItemViewModel(type: .email, text: email, becomeFirst: !isEmail)
        self.passwordItem = TextInputItemViewModel(type: .password(), becomeFirst: isEmail ? true : false)
        self.emailErrorItem = TextItemViewModel(errorHintText: "")
        self.passwordErrorItem = TextItemViewModel(errorHintText: "")
        
        self.items = [[
            TextItemViewModel(topTitle: "VerticalLayout"),
            EmptyItemViewModel(12),
            TextItemViewModel(hintText: "Log in to continue"),
            EmptyItemViewModel(24),
            self.emailItem!,
            EmptyItemViewModel(8),
            self.passwordItem!,
            EmptyItemViewModel(24),
            self.forgotPasswordItem!,
            EmptyItemViewModel(28),
            self.logInItem!
            ]]
    }
}

extension String {
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES%@", emailRegex)
        return emailTest.evaluate(with: self)
    }

    // Your password must contain at least 8 characters, 1 number, 1 upper case letter and 1 lower case letter
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: self)
    }
}
