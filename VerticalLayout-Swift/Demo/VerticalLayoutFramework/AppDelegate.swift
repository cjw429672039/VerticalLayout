//
//  AppDelegate.swift
//  VerticalLayoutFramework
//
//  Created by HarveyChen on 2020/4/15.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let shared = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.settingAPPRootVC()
        
        return true
    }

    func settingAPPRootVC() {
        let isLogin = (UserDefaults.standard.value(forKey: "isLogin") as? Bool) ?? false
        UserDefaults.standard.set(isLogin, forKey: "isLogin")
        if isLogin {
            let vc = SettingViewController()
            vc.viewModel = SettingViewModel()
            let navc = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = navc
        } else {
            let vc = LoginViewController()
            vc.viewModel = LoginViewModel()
            let navc = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = navc
        }
    }
}

