//
//  ForgotPasswordViewController.swift
//
//
//  Created.
//  Copyright © . All rights reserved.
//

import UIKit

class ForgotPasswordViewController: VLBaseViewController {
    override func handle(controllerResponse action: ViewControllerActionProtocol) {
        super.handle(controllerResponse: action)
        
        guard let action = action as? ForgotPasswordControllerAction else { return }
        switch action {
        case let .verifyEmail(email):
            self.navigationController?.pushViewController(LoginScene.verifyEmail(email: email).getVC(), animated: true)
        }
    }
}

extension ForgotPasswordViewController {
    // MARK: - UI配置
    override func configurateUI() {
        super.configurateUI()

        self.view.backgroundColor = .white
        self.tableView?.isScrollEnabled = false
    }
    // MARK: - 导航栏设置
    override func configurateNavigationBar() {
        super.configurateNavigationBar()
        
        self.setLeftBarItemImage(UIImage(named: "iconBackBlack"))
        self.navigationBar?.setLineView(color: UIColor.clear, hidden: true)
    }
}
