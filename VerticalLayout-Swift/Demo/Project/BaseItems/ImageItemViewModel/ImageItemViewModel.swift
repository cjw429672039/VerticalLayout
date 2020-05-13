//
//  ImageItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit

class ImageItemViewModel: VLBaseItemViewModel {

    let imageURLRelay = BehaviorRelay<URL?>(value: nil)
    let imagePlaceholderRelay = BehaviorRelay<UIImage?>(value: nil)
    let imageSizeRelay = BehaviorRelay<CGSize>(value: CGSize(width: 0, height: 0))

    init(urlString: String? = nil,
         placeholderImage: UIImage? = nil,
         height: CGFloat? = nil,
         selectType: SelectType? = nil) {
        super.init(itemSupportClassName: ImageTableViewCell.self, selectType: selectType)
        
        self.update(urlString: urlString,
                    placeholderImage: placeholderImage,
                    height: height)
    }
    
    init(image: UIImage?,
         height: CGFloat? = nil) {
        super.init(itemSupportClassName: ImageTableViewCell.self)
        self.update(placeholderImage: image)
    }
    
    func update(urlString: String? = nil,
                placeholderImage: UIImage? = nil,
                height: CGFloat? = nil) {
        if let urlString = urlString {
            self.imageURLRelay.accept(URL(string: urlString))
        }
        
        if let placeholderImage = placeholderImage {
            self.imagePlaceholderRelay.accept(placeholderImage)
        }
        
        if let height = height {
            self.cellHeight = height
        } else if let placeholderImage = placeholderImage {
            self.cellHeight = ECScaleHeight(placeholderImage.size.height)
        } else {
            self.cellHeight = ECScaleHeight(50)
        }

        if let size = placeholderImage?.size {
            if size.width == size.height {
                self.imageSizeRelay.accept(CGSize(width: self.cellHeight ?? 0, height: self.cellHeight ?? 0))
            } else {
                self.imageSizeRelay.accept(CGSize(width: ECScaleWidth(size.width), height: ECScaleHeight(size.height)))
            }
        } else {
            self.imageSizeRelay.accept(CGSize(width: self.cellHeight ?? 0, height: self.cellHeight ?? 0))
        }
    }
}
