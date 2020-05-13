//
//  UITextView+ECRx.swift
//  
//
//  Created by HarveyChen on 2020/4/27.
//  Copyright © 2020 . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITextView {
    public func ecBecomeFirstResponder() -> Binder<Bool> {
        return Binder(self.base) { view, status  in
            if status {
                view.becomeFirstResponder()
            } else {
                view.resignFirstResponder()
            }
        }
    }
}
