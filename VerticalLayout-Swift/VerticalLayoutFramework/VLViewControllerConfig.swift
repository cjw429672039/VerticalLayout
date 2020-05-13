//
//  VLViewControllerConfig.swift
//  VerticalLayoutFramework
//
//  Created by HarveyChen on 2020/4/15.
//  Copyright © 2020 . All rights reserved.
//

import Foundation
import UIKit

class VLViewControllerConfig {
    static func progressHUDSetting(type: ProgressHUDType) {
        KRProgressHUD.set(maskType: .clear)
        switch type {
        case .none:
            break
        case .fail(let msg, let duration):
            KRProgressHUD.set(style: .black)
            KRProgressHUD.set(font: VLSystemMediumFont(16))
            KRProgressHUD.set(duration: duration)
            if let msg = msg, msg.count != 0 {
                KRProgressHUD.showMessage(msg)
            } else {
                KRProgressHUD.showMessage("Fail")
            }
        case .success(let msg, let duration):
            KRProgressHUD.set(style: .black)
            KRProgressHUD.set(font: VLSystemMediumFont(16))
            KRProgressHUD.set(duration: duration)
            if let msg = msg, msg.count != 0 {
                KRProgressHUD.showMessage(msg)
            } else {
                KRProgressHUD.showMessage("Success")
            }
        case .show(let msg, let duration):
            KRProgressHUD.set(style: .black)
            KRProgressHUD.set(font: VLSystemMediumFont(16))
            KRProgressHUD.set(duration: duration)
            KRProgressHUD.showMessage(msg ?? "")
        case .loading(let msg):
            KRProgressHUD.set(style: .white)
            KRProgressHUD.set(font: VLSystemMediumFont(16))
            KRProgressHUD.show(withMessage: msg)
        case .hidden:
            KRProgressHUD.dismiss()
        }
    }
    
    static func alertViewActionSetting(type: AlertViewAction, action: @escaping (AlertViewActionProtocol) -> ()) {
        //第三方弹窗处理
        switch type {
        case .single(let title, let msg, let button, _, let actionProtocol):
            let alertController = UIAlertController(title: title,
                                                    message: msg,
                                                    preferredStyle: .alert)
            let first = UIAlertAction(title: button, style: .default) { (_) in
                action(actionProtocol)
            }
            alertController.addAction(first)
            AppDelegate.shared.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        case .double(let title, let msg, let firstButton, let secondButton, let actionProtocol, _):
            let alertController = UIAlertController(title: title,
                                                    message: msg,
                                                    preferredStyle: .alert)
            let first = UIAlertAction(title: firstButton, style: .default) { (_) in
                action(actionProtocol![0])
            }
            let second = UIAlertAction(title: secondButton, style: .default) { (_) in
                action(actionProtocol![1])
            }
            alertController.addAction(first)
            alertController.addAction(second)
            AppDelegate.shared.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        case .multiple:
            break
        case .none:
            break
        }
    }
    
    static func addPullToTopRefresh(tableView: UITableView?, action: () -> ()) {
        //第三方下拉刷新
    }
    
    static func addPullToBottomRefresh(tableView: UITableView?, action: () -> ()) {
        //第三方上拉加载
    }
    
    static func endRefreshSetting(tableView: UITableView?) {
        //第三方结束刷新
    }
    
    static func viewControllerDeinit(tableView: UITableView?) {
        //视图释放
    }
}
