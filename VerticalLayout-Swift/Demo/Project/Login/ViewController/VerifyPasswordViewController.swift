//
//  VerifyPasswordViewController.swift
//
//
//  Created.
//  Copyright © . All rights reserved.
//

import UIKit

class VerifyPasswordViewController: VLBaseViewController {
    override func handle(controllerResponse action: ViewControllerActionProtocol) {
        super.handle(controllerResponse: action)
        
        guard let action = action as? VerifyPasswordControllerAction else { return }
        switch action {
        case .pop:
            self.navigationController?.popViewController(animated: true)
        case let .changePassword(currentPwd):
            self.navigationController?.pushViewController(LoginScene.changePassword(type: .changePassword(currentPassword: currentPwd)).getVC(), animated: true)
        }
    }
}

extension VerifyPasswordViewController {
    // MARK: - UI配置
    override func configurateUI() {
        super.configurateUI()

        self.view.backgroundColor = .white
        self.tableView?.isScrollEnabled = false
    }
    
    // MARK: - 导航栏设置
    override func configurateNavigationBar() {
        super.configurateNavigationBar()
        
        self.navigationBar?.setLineView(color: UIColor.clear, hidden: true)
        self.setLeftBarItemImage(UIImage(named: "iconBackBlack"))
    }
}
