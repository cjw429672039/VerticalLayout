//
//  UIButton+ECRx.swift
//  
//
//  Created by HarveyChen on 2020/4/20.
//  Copyright © 2020 . All rights reserved.
//

import Foundation
import Kingfisher
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {

    public func ecImageURL(withPlaceholder placeholderImage: UIImage?, state: UIControl.State, options: KingfisherOptionsInfo = []) -> Binder<URL?> {
        return Binder(self.base, binding: { (button, url) in
            button.kf.setImage(with: url, for: .normal, placeholder: placeholderImage, options: options, progressBlock: nil, completionHandler: nil)
        })
    }
    
    public func ecBackgroundImageURL(withPlaceholder placeholderImage: UIImage?, state: UIControl.State, options: KingfisherOptionsInfo = []) -> Binder<URL?> {
        return Binder(self.base, binding: { (button, url) in
            button.kf.setBackgroundImage(with: url, for: .normal, placeholder: placeholderImage, options: options, progressBlock: nil, completionHandler: nil)
        })
    }
    
    public var ecContentHorizontalAlignment: Binder<UIControl.ContentHorizontalAlignment> {
        return Binder(self.base) { button, alignment in
            button.contentHorizontalAlignment = alignment
        }
    }
}
