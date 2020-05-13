//
//  LoginViewController.swift
//
//
//  Created.
//  Copyright © . All rights reserved.
//

import UIKit

class LoginViewController: VLBaseViewController {
    override func handle(controllerResponse action: ViewControllerActionProtocol) {
        super.handle(controllerResponse: action)
        
        guard let action = action as? LoginControllerAction else { return }
        switch action {
        case .loginSuccess:
            UserDefaults.standard.setValue(true, forKey: "isLogin")
            AppDelegate.shared.settingAPPRootVC()
        case let .forgotPassword(email):
            self.navigationController?.pushViewController(LoginScene.forget(email: email).getVC(), animated: true)
        case let .resetPassword(email, password):
            self.navigationController?.pushViewController(LoginScene.changePassword(type: .firstLogin(email: email, currentPassword: password)).getVC(), animated: true)
        }
    }
}

extension LoginViewController {
    // MARK: - UI配置
    override func configurateUI() {
        super.configurateUI()
        
        self.view.backgroundColor = .white
        self.tableView?.isScrollEnabled = false
    }

    // MARK: - 导航栏设置
    override func configurateNavigationBar() {
        super.configurateNavigationBar()
        
        self.navigationBar?.isHidden = true
    }
}
