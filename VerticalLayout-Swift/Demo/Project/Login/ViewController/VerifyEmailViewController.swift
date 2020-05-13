//
//  VerifyEmailViewController.swift
//
//
//  Created.
//  Copyright © . All rights reserved.
//

import UIKit

class VerifyEmailViewController: VLBaseViewController {
    private var backImageView: UIImageView?
    
    override func handle(controllerResponse action: ViewControllerActionProtocol) {
        super.handle(controllerResponse: action)
        
        guard let action = action as? VerifyEmailControllerAction else { return }
        switch action {
        case let .changePassword(code, email):
            self.navigationController?.pushViewController(LoginScene.changePassword(type: .forgotPassword(email: email, code: code)).getVC(), animated: true)
        case let .getSupport(email):
            self.navigationController?.pushViewController(LoginScene.getSupport(email: email).getVC(), animated: true)
        }
    }
}

extension VerifyEmailViewController {
    // MARK: - UI配置
    override func configurateUI() {
        super.configurateUI()

        self.view.backgroundColor = .white
        self.tableView?.isScrollEnabled = false
    }
    // MARK: - addsubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.view.addSubview(self.backImageView!)
        self.view.sendSubviewToBack(self.backImageView!)
        
        self.backImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.navigationBar!.snp_bottom).offset(VLScaleHeight(50))
            make.left.right.equalToSuperview()
        })
    }
    // MARK: - 实例化对象
    override func configurateInstance() {
        super.configurateInstance()
        
        self.backImageView = UIImageView()
        backImageView?.contentMode = .scaleAspectFit
        backImageView?.image = UIImage(named: "illustrationsSendEmail")
    }
    // MARK: - 导航栏设置
    override func configurateNavigationBar() {
        super.configurateNavigationBar()
        
        self.navigationBar?.setLineView(color: UIColor.clear, hidden: true)
        self.setLeftBarItemImage(UIImage(named: "iconBackBlack"))
    }
}
