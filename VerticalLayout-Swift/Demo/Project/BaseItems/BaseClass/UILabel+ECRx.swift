//
//  UILabel+Rx.swift
//  Assureapt
//
//  Created by HarveyChen on 2020/3/30.
//  Copyright © 2020 . All rights reserved.
//

#if os(iOS) || os(tvOS)

import RxSwift
import UIKit

extension Reactive where Base: UILabel {
    
    /// Bindable sink for `text` property.
    public var ecTextAlignment: Binder<NSTextAlignment> {
        return Binder(self.base) { label, textAlignment in
            label.textAlignment = textAlignment
        }
    }
}

#endif
