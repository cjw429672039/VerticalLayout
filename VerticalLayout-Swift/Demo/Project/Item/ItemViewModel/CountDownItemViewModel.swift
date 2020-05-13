//
//  CountDownItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit

class CountDownItemViewModel: VLBaseItemViewModel {
    let countDownEnd = BehaviorRelay<Bool>(value: false)
    let secondRelay = BehaviorRelay<Int>(value: 0)
    
    init(second: Int) {
        super.init(itemSupportClassName: CountDownTableViewCell.self,
                   cellHeight: VLScaleHeight(21.5))
        self.secondRelay.accept(second)
    }
}
