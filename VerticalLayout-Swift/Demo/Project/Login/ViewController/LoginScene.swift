//
//  LoginScene.swift
//  Assureapt
//
//  Created by HarveyChen on 2020/1/4.
//  Copyright © 2020 . All rights reserved.
//

import Foundation

protocol SceneType {
    func getVC() -> UIViewController
}

enum LoginScene: SceneType {
    case login
    case forget(email: String?)
    case verifyEmail(email: String)
    case getSupport(email: String)
    case verifyPassword(action: VerifyPasswordActionType)
    case changePassword(type: ChangePasswordType)
}

extension LoginScene {
    
    func getVC() -> UIViewController {
        switch self {
        case .login:
            let loginVC = LoginViewController()
            loginVC.viewModel = LoginViewModel()
            return loginVC
        case let .forget(email):
            let forgotVC = ForgotPasswordViewController()
            forgotVC.viewModel = ForgotPasswordViewModel(email: email)
            return forgotVC
        case let .verifyEmail(email):
            let verifyEmailVC = VerifyEmailViewController()
            verifyEmailVC.viewModel = VerifyEmailViewModel(email: email)
            return verifyEmailVC
        case let .getSupport(email):
            let getSupportVC = GetSupportViewController()
            getSupportVC.viewModel = GetSupportViewModel(email: email)
            return getSupportVC
        case let .verifyPassword(msg):
            let vc = VerifyPasswordViewController()
            vc.viewModel = VerifyPasswordViewModel(type: msg)
            return vc
        case let .changePassword(type):
            let vc = ChangePasswordViewController()
            vc.viewModel = ChangePasswordViewModel(type: type)
            return vc
        }
    }
}
