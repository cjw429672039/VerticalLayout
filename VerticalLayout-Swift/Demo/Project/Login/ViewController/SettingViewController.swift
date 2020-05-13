//
//  SettingViewController.swift
//
//
//  Created.
//  Copyright © . All rights reserved.
//

import UIKit

class SettingViewController: VLBaseViewController {
    
    override func handle(controllerResponse action: ViewControllerActionProtocol) {
        guard let action = action as? SettingControllerAction  else {
            return
        }
        switch action {
        case .logout:
            UserDefaults.standard.set(false, forKey: "isLogin")
            AppDelegate.shared.settingAPPRootVC()
        }
    }
}

extension SettingViewController {
    // MARK: - 对象配置
    override func configurateUI() {
        super.configurateUI()
        
    }
    
    // MARK: - 对象布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
    }
    
    // MARK: - 对象实例化
    override func configurateInstance() {
        super.configurateInstance()
        
    }
                            
    // MARK: - 导航栏设置
    override func configurateNavigationBar() {
        super.configurateNavigationBar()
        
        self.setTitle(title: "Settings")
    }
}
