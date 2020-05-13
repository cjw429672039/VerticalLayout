//
//  TextInputItemViewModel.swift
//  
//
//  Created by HarveyChen on 2020/4/21.
//  Copyright © 2020 . All rights reserved.
//

import Foundation
import UIKit

enum TextInputUseType {
    case email
    case password(placeHolder: String? = "Password")
}

extension TextInputItemViewModel {
    convenience init (type: TextInputType,
                      leftImage: UIImage,
                      placeHolderString: String? = nil,
                      text: String? = nil,
                      password: Bool = false,
                      keyboardType: UIKeyboardType = .default,
                      maxLength: Int = 0,
                      becomeFirst: Bool = false,
                      textFieldRightSpace: CGFloat? = -VLScaleWidth(12),
                      rightImage: UIImage? = nil,
                      lineColor: UIColor = TextColor.ox00C389.color()) {
        self.init(type: type,
                  leftImage: leftImage,
                  leftImageLeftSpace: VLScaleWidth(20),
                  placeHolderString: placeHolderString,
                  placeHolderColor: TextColor.oxBBBBBB.color(),
                  placeHolderFont: VLSystemRegularFont(16),
                  text: text,
                  textColor: TextColor.ox333333.color(),
                  textFont: VLSystemRegularFont(16),
                  password: password,
                  keyboardType: keyboardType,
                  tinColor: TextColor.ox00C389.color(),
                  maxLength: maxLength,
                  becomeFirst: becomeFirst,
                  textFieldLeftSpace: VLScaleWidth(12),
                  textFieldRightSpace: textFieldRightSpace,
                  rightImage: rightImage,
                  rightImageRightSpace: -VLScaleWidth(20),
                  line: true,
                  lineColor: lineColor,
                  lineLayout: (VLScaleWidth(20), -VLScaleWidth(20), 0, VLScaleHeight(2)),
                  height: VLScaleHeight(60))
    }
    
    convenience init(type: TextInputUseType, text: String? = nil, becomeFirst: Bool = false) {
        switch type {
        case .email:
            self.init(type: .leftImageTextField,
                      leftImage: UIImage(named: "iconEmail"),
                      placeHolderString: "Email",
                      text: text,
                      password: false,
                      keyboardType: .emailAddress,
                      maxLength: 100,
                      becomeFirst: becomeFirst,
                      textFieldRightSpace: -VLScaleWidth(20),
                      line: true,
                      lineColor: TextColor.oxDDDDDD.color(),
                      lineLayout: (VLScaleWidth(20), -VLScaleWidth(20), 0, VLScaleHeight(2)),
                      height: VLScaleHeight(60))
        case let .password(placeHolder):
            self.init(type: .leftImageTextFieldRightImage,
                      leftImage: UIImage(named: "iconPassword"),
                      placeHolderString: placeHolder,
                      text: text,
                      password: true,
                      keyboardType: .default,
                      maxLength: 100,
                      becomeFirst: becomeFirst,
                      rightImage: UIImage(named: "iconInvisible"),
                      line: true,
                      lineColor: TextColor.oxDDDDDD.color(),
                      lineLayout: (VLScaleWidth(20), -VLScaleWidth(20), 0, VLScaleHeight(2)),
                      height: VLScaleHeight(60))
            passwordRightImage()
        }
        monitorTextField()
    }
    
    func errorStatus() {
        self.update(lineColor: VLHexColor(0xFA584D))
    }
    
    func normalStatus() {
        self.update(lineColor: VLHexColor(0xDDDDDD))
    }
}

extension TextInputItemViewModel {
    private func passwordRightImage() {
        rightAction.subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
            self.isPasswordRelay.accept(!self.isPasswordRelay.value)
            switch self.isPasswordRelay.value {
            case true:
                self.update(rightImage: UIImage(named: "iconInvisible"))
            case false:
                self.update(rightImage: UIImage(named: "iconVisible"))
            }
        }).disposed(by: disposeBag)
    }
    
    private func monitorTextField() {
        self.textFieldEventRelay.subscribe(onNext: {[weak self] (type) in
            guard let self = self else { return }
            switch type {
            case .editingDidEnd:
                self.update(lineColor: VLHexColor(0xDDDDDD))
            case .editingDidBegin:
                self.update(lineColor: VLHexColor(0x00C389))
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}
