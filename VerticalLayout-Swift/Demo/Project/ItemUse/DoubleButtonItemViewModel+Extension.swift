//
//  DoubleButtonItemViewModel+Extension.swift
//
//
//  Created by HarveyChen on 2020/4/27.
//  Copyright © 2020 . All rights reserved.
//

import Foundation

extension DoubleButtonItemViewModel {
    convenience init(leftImage: UIImage?,
                     rightImage: UIImage?) {
        self.init(leftImage: leftImage,
                  rightImage: rightImage,
                  height: VLScaleHeight(44))
    }
    
    convenience init(lineLeftText: String?,
                     lineRightText: String) {
        self.init(leftText: lineLeftText,
                  leftTextColor: VLHexColor(0x00C389),
                  leftTextFont: VLSystemRegularFont(14),
                  leftTextLine: true,
                  rightText: lineRightText,
                  rightTextColor: VLHexColor(0x00C389),
                  rightTextFont: VLSystemRegularFont(14),
                  rightTextLine: true)
    }
}
