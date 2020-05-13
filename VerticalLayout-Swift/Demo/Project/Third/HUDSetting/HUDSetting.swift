//
//  HUDSetting.swift
//  Assureapt
//
//  Created by HarveyChen on 2020/4/8.
//  Copyright © 2020 . All rights reserved.
//

import Foundation

class HUDSetting {
    static let shareInstance = HUDSetting()
    
    func krConfig(type: ProgressHUDType) {
        
        KRProgressHUD.set(maskType: .clear)
        
        switch type {
        case .none:
            break
        case let .fail(msg, duration):
            KRProgressHUD.set(style: .black)
            KRProgressHUD.set(font: VLSystemMediumFont(16))
            KRProgressHUD.set(duration: duration)
            if let msg = msg, msg.count != 0 {
                KRProgressHUD.showMessage(msg)
            } else {
                KRProgressHUD.showMessage("Fail")
            }
        case let .success(msg, duration):
            KRProgressHUD.set(style: .black)
            KRProgressHUD.set(font: VLSystemMediumFont(16))
            KRProgressHUD.set(duration: duration)
            if let msg = msg, msg.count != 0 {
                KRProgressHUD.showMessage(msg)
            } else {
                KRProgressHUD.showMessage("Success")
            }
        case let .show(msg, duration):
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
}
