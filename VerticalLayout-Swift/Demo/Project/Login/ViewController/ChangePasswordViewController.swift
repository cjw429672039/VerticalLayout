//
//  ChangePasswordViewController.swift
//
//
//  Created.
//  Copyright © . All rights reserved.
//

import UIKit

class ChangePasswordViewController: VLBaseViewController {
    override func handle(controllerResponse action: ViewControllerActionProtocol) {
        super.handle(controllerResponse: action)
        
        guard let action = action as? ChangePasswordControllerAction else { return }
        switch action {
        case .relogin:
            UserDefaults.standard.setValue(false, forKey: "isLogin")
            AppDelegate.shared.settingAPPRootVC()// 密码修改成功后需要重新登陆
        case let .webPage(title, urlString):
            print(title, urlString)
        }
    }
}

extension ChangePasswordViewController {
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
