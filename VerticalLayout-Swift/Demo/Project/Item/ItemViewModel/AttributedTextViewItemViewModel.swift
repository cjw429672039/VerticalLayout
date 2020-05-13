//
//  AttributedTextViewItemViewModel.swift
//
//
//  Created
//  Copyright ©  All rights reserved.
//

import UIKit

class AttributedTextViewItemViewModel: VLBaseItemViewModel {
    let leftOffsetRelay = BehaviorRelay<CGFloat?>(value: VLScaleWidth(20))
    let rightOffsetRelay = BehaviorRelay<CGFloat?>(value: VLScaleWidth(20))
    let attrTextRelay = BehaviorRelay<String?>(value: nil)
    let textAlignmentRelay = BehaviorRelay<NSTextAlignment?>(value: nil)
    let linkTextItemsRelay = BehaviorRelay<[String]>(value: [])
    let linkURLItemsRelay = BehaviorRelay<[URL]>(value: [])
    let linkTextColorRelay = BehaviorRelay<UIColor>(value: .white)
    let linkActionRelay = BehaviorRelay<URL?>(value: nil)

    init(leftOffset: CGFloat = VLScaleWidth(20),
         rightOffset: CGFloat = VLScaleWidth(20),
         title: String?,
         linkTextItems: [String],
         linkURLItems: [URL],
         linkTextColor: UIColor = VLHexColor(0x00C389),
         textAlignment: NSTextAlignment = .left) {
        super.init(itemSupportClassName: AttributedTextViewTableViewCell.self)
        leftOffsetRelay.accept(leftOffset)
        rightOffsetRelay.accept(rightOffset)
        textAlignmentRelay.accept(textAlignment)
        attrTextRelay.accept(title)
        linkTextColorRelay.accept(linkTextColor)
        linkTextItemsRelay.accept(linkTextItems)
        linkURLItemsRelay.accept(linkURLItems)
        self.cellHeight = title!.getSize(font: VLSystemRegularFont(12), width: VLScreenW - leftOffset - leftOffset).height + 15
    }
}

extension AttributedTextViewItemViewModel {
    private func attrString(title: String?) -> NSAttributedString {
            return NSAttributedString(string: title ?? "", textColor: VLHexColor(0x999999), font: VLSystemRegularFont(12))
    }
}

extension String {

    // MARK: - 获取字符串大小
    func getSize(font: UIFont, width: CGFloat = UIScreen.main.bounds.width) -> CGSize {
        let str = self as NSString
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
}

extension NSAttributedString {
    func getSize(width: CGFloat) -> CGSize {
        var size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size
        size = CGSize(width: size.width, height: size.height + 1)
        return size
    }
    
    convenience init(string: String?,
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
        self.init(string: string ?? "", attributes: newAttrs)
    }
}
