//
//  GetSupportViewController.swift
//
//
//  Created.
//  Copyright © . All rights reserved.
//

import UIKit

class GetSupportViewController: VLBaseViewController {
    override func handle(controllerResponse action: ViewControllerActionProtocol) {
        super.handle(controllerResponse: action)
        
        guard let action = action as? GetSupportControllerAction else { return }
        switch action {
        case let .call(phone):
            guard !phone.isEmpty else { return }
            let telURL: URL = URL(string: "tel:\(phone)")!
            if UIApplication.shared.canOpenURL(telURL) {
                UIApplication.shared.open(telURL, options: [:], completionHandler: nil)
            }
        }
    }
}

extension GetSupportViewController {
    // MARK: - UI配置
    override func configurateUI() {
        super.configurateUI()

        self.tableView?.backgroundColor = .white
    }
    // MARK: - 导航栏设置
    override func configurateNavigationBar() {
        super.configurateNavigationBar()

        self.navigationBar?.setLineView(color: UIColor.clear, hidden: true)
        self.setLeftBarItemImage(UIImage(named: "iconBackBlack"))
    }
}
