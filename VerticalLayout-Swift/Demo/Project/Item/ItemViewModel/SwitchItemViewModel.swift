//
//  SwitchItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit

class SwitchItemViewModel: VLBaseItemViewModel {
    let leftAttTextRelay = BehaviorRelay<NSAttributedString?>(value: nil)
    let rightAttTextRelay = BehaviorRelay<NSAttributedString?>(value: nil)
    let rightImageRelay = BehaviorRelay<UIImage?>(value: nil)
    let rightButtonAction = BehaviorRelay<Void>(value: ())
    let rightLottie = BehaviorRelay<String?>(value: nil)
    let rightLottieValue = BehaviorRelay<Bool>(value: false)
    
    init(title: String?,
         image: UIImage?,
         line: Bool = false) {
        super.init(itemSupportClassName: SwitchTableViewCell.self,
                   line: line,
                   cellHeight: VLScaleHeight(60))
        self.leftAttTextRelay.accept(self.attString(title: title))
        self.rightImageRelay.accept(image)
    }
    
    init(title: String?,
         switchValue: Bool,
         switchName: String = "switch",
         line: Bool = false,
         selectType: SelectType? = nil) {
        super.init(itemSupportClassName: SwitchTableViewCell.self,
                   line: line,
                   cellHeight: VLScaleHeight(60),
                   selectType: selectType)
        self.leftAttTextRelay.accept(self.attString(title: title))
        self.rightLottie.accept(switchName)
        self.rightLottieValue.accept(switchValue)
    }
    
    func update(switchValue: Bool) {
        self.rightLottieValue.accept(switchValue)
    }
}

extension SwitchItemViewModel {
    private func attString(title: String?) -> NSAttributedString {
        return NSAttributedString(string: title ?? "",
                                  textColor: VLHexColor(0x333333),
                                  font: VLSystemRegularFont(16))
    }
}
