//
//  EmptyItemViewModel.swift
//  Assureapt
//
//  Created by HarveyChen on 2020/1/3.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class EmptyItemViewModel: VLBaseItemViewModel {
    let viewBGColorRelay = BehaviorRelay<UIColor>(value: .clear)
    init(_ height: CGFloat,
         line: Bool = false,
         lineLayout: (left: CGFloat, right: CGFloat, bottom: CGFloat, height: CGFloat)? = nil,
         viewBGColor: UIColor = .clear) {
        super.init(itemSupportClassName: EmptyTableViewCell.self,
                   line: line,
                   cellHeight: height)
        self.viewBGColorRelay.accept(viewBGColor)
        if let lineLayout = lineLayout {
            self.lineLayoutRelay.accept(lineLayout)
        }
    }
}
