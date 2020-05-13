//
//  GetSupportViewModel.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit
import RxSwift

enum GetSupportAlertType: AlertViewActionProtocol {
    case cancel
    case call(phone: String)
}

enum GetSupportControllerAction: ViewControllerActionProtocol {
    case call(phone: String)
}

class GetSupportViewModel: VLBaseViewModel {
    
    private var contactActionItem: ButtonItemViewModel?
    private var email: String?
    
    init(email: String) {
        self.email = email
        super.init()
    }
    
    override func signalTransform(input: VLBaseViewModel.SignalInput) -> VLBaseViewModel.SignalOutput {
        //contact按钮点击
        self.contactActionItem?.action.bind(to: self.rx.contactActionRequest()).disposed(by: disposeBag)
        return super.signalTransform(input: input)
    }
    
    func getCommunityPhoneByTenantMail() {
        guard let email = self.email, email.isEmail() else { return }
        self.contactActionItem?.update(loading: true)
        self.tableViewAction.accept(.enable(status: false))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let  num = arc4random()
            switch num % 2 {
            case 0:
                self.viewControllerAction.accept(GetSupportControllerAction.call(phone: "18359100000"))
            case 1:
                break
            default:
                break
            }
            self.contactActionItem?.update(loading: false)
            self.tableViewAction.accept(.enable(status: true))
        }
    }
}

extension Reactive where Base: GetSupportViewModel {
    func contactActionRequest() -> Binder<Void> {
        return Binder(self.base) { (viewModel, _) in
            viewModel.getCommunityPhoneByTenantMail()
        }
    }
}

extension GetSupportViewModel {
    
    //items配置以及其他数据配置(在init调用)
    override func configurateInstance() {
        super.configurateInstance()
        
        self.contactActionItem = ButtonItemViewModel(greenBGWhiteText: "Contact Property Management")
        self.items = [[EmptyItemViewModel(VLScaleHeight(20)),
                       TextItemViewModel(topTitle: "Get Support",
                                         textFont: .bold(size: 27)),
                       EmptyItemViewModel(VLScaleHeight(20)),
                       TextItemViewModel(hintText: "Troubleshooting steps to why you didn't get the verification email."),
                       EmptyItemViewModel(VLScaleHeight(28)),
                       createImageTitleItemViewModel(title: "Typo"),
                       EmptyItemViewModel(VLScaleHeight(8)),
                       createTitleOnlyItemViewModel(title: "Check to make sure the email address is spelled correctly. If not, verify the address with the correct spelling."),
                       EmptyItemViewModel(VLScaleHeight(28)),
                       createImageTitleItemViewModel(title: "Spam or Junk Folder"),
                       EmptyItemViewModel(VLScaleHeight(8)),
                       createTitleOnlyItemViewModel(title: "Verification emails may be filtered directly into your email program's spam or junk mail folder. "),
                       EmptyItemViewModel(VLScaleHeight(28)),
                       createImageTitleItemViewModel(title: "Blocked or Bounced Address"),
                       EmptyItemViewModel(VLScaleHeight(8)),
                       createTitleOnlyItemViewModel(title: """
If you tried to verify a specific email address but did not receive the verification email,
your ISP or corporate domain may have blocked the email. Although Constant Contact averages a very low block rate of around 3%,
it's possible that your email address may be part of that 3%. If you haven't received any Constant Contact emails, try verifying an alternative email address
"""),
                       EmptyItemViewModel(VLScaleHeight(28)),
                       createImageTitleItemViewModel(title: "Web Browser Needs a Refresh"),
                       EmptyItemViewModel(VLScaleHeight(8)),
                       createTitleOnlyItemViewModel(title: "Occasionally you'll need to manually refresh your browser to check for new emails."),
                       EmptyItemViewModel(VLScaleHeight(28)),
                       createImageTitleItemViewModel(title: "Account email is not available"),
                       EmptyItemViewModel(VLScaleHeight(8)),
                       createTitleOnlyItemViewModel(title: "If your account email address is not available，please contact your property management for additional support. "),
                       EmptyItemViewModel(VLScaleHeight(36)),
                       self.contactActionItem!,
                       EmptyItemViewModel(VLScaleHeight(36))]]
    }
    
    private func createImageTitleItemViewModel(title: String) -> TextListItemViewModel {
        return TextListItemViewModel(style: .leftImageText(leftImageLeftSpace: VLScaleWidth(20),
                                                           leftLabelLeftSpace: VLScaleWidth(8),
                                                           leftLabelRightSpace: -VLScaleWidth(20)),
                                     leftPlaceImage: UIImage(named: "iconLabelPoint"),
                                     leftText: title,
                                     leftTextColor: TextColor.ox333333.color(),
                                     leftTextFont: TextFont.bold(size: 16).font(),
                                     line: false,
                                     arrow: false,
                                     height: VLScaleHeight(21.5))
    }
    
    private func createTitleOnlyItemViewModel(title: String) -> TextItemViewModel {
        return TextItemViewModel(hintText: title)
    }
}
