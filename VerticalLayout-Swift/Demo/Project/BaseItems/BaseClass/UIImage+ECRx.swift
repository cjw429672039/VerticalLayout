//
//  SDWebImage+RX.swift
//  VeSync
//
//  Created by dave on 2019/8/17.
//  Copyright © 2019年 . All rights reserved.
//

import Kingfisher
import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
    
    public var ecImageURL: Binder<URL?> {
        return self.ecImageURL(withPlaceholder: nil, options: [])
    }
    
    public func ecImageURL(withPlaceholder placeholderImage: UIImage?, options: KingfisherOptionsInfo) -> Binder<URL?> {
        return Binder(self.base, binding: { (imageView, url) in
            imageView.kf.setImage(with: url, placeholder: placeholderImage, options: options, progressBlock: nil, completionHandler: nil)
        })
    }
}
