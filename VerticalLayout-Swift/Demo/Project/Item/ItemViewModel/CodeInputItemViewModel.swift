//
//  CodeInputItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit

class CodeInputItemViewModel: VLBaseItemViewModel {
    let textEditEventRelay = PublishRelay<UIControl.Event>()
    let codeText: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let becomeFirstRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    let codeInputErrorRelay = BehaviorRelay<Bool>(value: false)
    let codeInputEndRelay = PublishRelay<Void>()

    init() {
        super.init(itemSupportClassName: CodeInputTableViewCell.self,
                   cellHeight: VLScaleHeight(50))
    }
}
