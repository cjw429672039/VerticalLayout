//
//  SettingViewModel.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

enum SettingSelectType: SelectType {
    case account
    case device
    case mode
    case notifications
    case logout
}

enum SettingControllerAction: ViewControllerActionProtocol {
    case logout
}

enum SettingAlertType: AlertViewActionProtocol {
    case cancel
    case logout
}

class SettingViewModel: VLBaseViewModel {
    override func signalTransform(input: VLBaseViewModel.SignalInput) -> VLBaseViewModel.SignalOutput {
        
        return super.signalTransform(input: input)
    }
    
    override func handle(alertClick action: AlertViewActionProtocol) {
        guard let action = action as? SettingAlertType else {
            return
        }
        
        switch action {
        case .logout:
            self.viewControllerAction.accept(SettingControllerAction.logout)
        default:
            break
        }
    }
    
    override func handle(tableClick action: SelectType) {
        guard let action = action as? SettingSelectType else {
            return
        }
        
        switch action {
        case .logout:
            self.alertViewAction.accept(.double(title: "Log out",
                                                msg: nil,
                                                firstButton: "Cancel",
                                                secondButton: "OK",
                                                actions: [SettingAlertType.cancel, SettingAlertType.logout],
                                                colors: nil))
        default:
            break
        }
    }
}

extension SettingViewModel {
                        
    //items配置以及其他数据配置(在init调用)
    override func configurateInstance() {
        super.configurateInstance()
        self.items = [[
            EmptyItemViewModel(VLScaleHeight(12)),
            TextListItemViewModel(leftText: "Account Settings",
                                  line: false,
                                  arrow: true,
                                  selectType: SettingSelectType.account),
            EmptyItemViewModel(VLScaleHeight(8)),
            TextItemViewModel(lightHintText: "Manage password and biometric settings", leftSpace: VLScaleWidth(16), rightSpace: -VLScaleWidth(16)),
            EmptyItemViewModel(VLScaleHeight(28)),
            TextListItemViewModel(leftText: "Device Settings",
                                  line: false,
                                  arrow: true,
                                  selectType: SettingSelectType.device),
            EmptyItemViewModel(VLScaleHeight(8)),
            TextItemViewModel(lightHintText: "Manage devices and firmware", leftSpace: VLScaleWidth(16), rightSpace: -VLScaleWidth(16)),
            EmptyItemViewModel(VLScaleHeight(28)),
            TextListItemViewModel(leftText: "Mode Settings",
                                  line: false,
                                  arrow: true,
                                  selectType: SettingSelectType.mode),
            EmptyItemViewModel(VLScaleHeight(8)),
            TextItemViewModel(lightHintText: "Manage Away, Home, and Off mode settings", leftSpace: VLScaleWidth(16), rightSpace: -VLScaleWidth(16)),
            EmptyItemViewModel(VLScaleHeight(28)),
            TextListItemViewModel(leftText: "Notifications",
                                  line: false,
                                  arrow: true,
                                  selectType: SettingSelectType.notifications),
            EmptyItemViewModel(VLScaleHeight(8)),
            TextItemViewModel(lightHintText: "Manage device alerts and notifications", leftSpace: VLScaleWidth(16), rightSpace: -VLScaleWidth(16)),
            EmptyItemViewModel(VLScaleHeight(28)),
            TextListItemViewModel(leftText: "Log out",
                                  line: false,
                                  arrow: true,
                                  selectType: SettingSelectType.logout)
            ]]
    }
}
