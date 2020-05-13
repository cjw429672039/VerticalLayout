//
//  NSAttributedString+ECExtension.swift
//  
//
//  Created by HarveyChen on 2020/4/20.
//  Copyright © 2020 . All rights reserved.
//

import Foundation

extension NSAttributedString {
    func ecGetSize(width: CGFloat) -> CGSize {
        var size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size
        size = CGSize(width: size.width, height: size.height + 1)
        return size
    }
    
    convenience init(ecString: String?,
                     textColor: UIColor,
                     font: UIFont,
                     line: Bool = false,
                     attrs: [NSAttributedString.Key: Any]? = nil) {
        var newAttrs = [NSAttributedString.Key.font: font,
                     NSAttributedString.Key.foregroundColor: textColor]
        if line {
            newAttrs[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue as NSObject
        }
        if let attrs = attrs {
            for (key, value) in attrs {
                newAttrs[key] = value as? NSObject
            }
        }
        self.init(string: ecString ?? "", attributes: newAttrs)
    }
}
