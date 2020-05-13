//
//  TextItemViewModel+Extension.swift
//  
//
//  Created by HarveyChen on 2020/4/20.
//  Copyright © 2020 . All rights reserved.
//

import Foundation

enum TextColor {
    case ox333333
    case ox666666
    case ox999999
    case oxBBBBBB
    case oxDDDDDD
    case oxF1F1F1
    case oxFA584D
    case oxFFFFFF
    case ox00C389
    case clear
    
    func color() -> UIColor {
        switch self {
        case .ox333333:
            return VLHexColor(0x333333)
        case .ox666666:
            return VLHexColor(0x666666)
        case .ox999999:
            return VLHexColor(0x999999)
        case .oxBBBBBB:
            return VLHexColor(0xBBBBBB)
        case .oxDDDDDD:
            return VLHexColor(0xDDDDDD)
        case .oxF1F1F1:
            return VLHexColor(0xF1F1F1)
        case .oxFFFFFF:
            return VLHexColor(0xFFFFFF)
        case .ox00C389:
            return VLHexColor(0x00C389)
        case .oxFA584D:
            return VLHexColor(0xFA584D)
        case .clear:
            return .clear
        }
    }
}

enum TextFont {
    case regular(size: CGFloat, scale: Bool = true)
    case medium(size: CGFloat, scale: Bool = true)
    case bold(size: CGFloat, scale: Bool = true)
    
    func font() -> UIFont {
        switch self {
        case let .regular(size, scale):
            return VLSystemRegularFont(size, isScale: scale)
        case let .medium(size, scale):
            return VLSystemMediumFont(size, isScale: scale)
        case let .bold(size, scale):
            return VLSystemBoldFont(size, isScale: scale)
        }
    }
}

//便捷统一和配置文字item
extension TextItemViewModel {
    //头部大标题
    convenience init(topTitle: String?,
                     textColor: TextColor? = .ox333333,
                     textFont: TextFont? = .bold(size: 25)) {
        self.init(text: topTitle,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  leftSpace: VLScaleWidth(20),
                  rightSpace: -VLScaleWidth(20))
    }
    //中部标题
    convenience init(middleTitle: String?,
                     textColor: TextColor? = .ox333333,
                     textFont: TextFont? = .bold(size: 18),
                     textAlignment: NSTextAlignment? = nil,
                     leftSpace: CGFloat? = VLScaleWidth(20),
                     rightSpace: CGFloat? = -VLScaleWidth(20)) {
        self.init(text: middleTitle,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  textAlignment: textAlignment,
                  leftSpace: leftSpace,
                  rightSpace: rightSpace)
    }
    //弹窗中部标题
    convenience init(alertMiddleTitle: String?,
                     textColor: TextColor? = .ox333333,
                     textFont: TextFont? = .medium(size: 18),
                     textAlignment: NSTextAlignment? = .center,
                     leftSpace: CGFloat? = VLScaleWidth(24),
                     rightSpace: CGFloat? = -VLScaleWidth(24),
                     cellWidth: CGFloat? = VLScreenW - VLScaleWidth(50 + 48)) {
        self.init(text: alertMiddleTitle,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  textAlignment: textAlignment,
                  leftSpace: leftSpace,
                  rightSpace: rightSpace,
                  cellWidth: cellWidth)
    }
    //弹窗消息内容
    convenience init(alertMessageTitle: String?,
                     textColor: TextColor? = .ox999999,
                     textFont: TextFont? = .regular(size: 16),
                     textAlignment: NSTextAlignment? = .center,
                     leftSpace: CGFloat? = VLScaleWidth(24),
                     rightSpace: CGFloat? = -VLScaleWidth(24),
                     cellWidth: CGFloat? = VLScreenW - VLScaleWidth(50 + 48)) {
        self.init(text: alertMessageTitle,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  textAlignment: textAlignment,
                  leftSpace: leftSpace,
                  rightSpace: rightSpace,
                  cellWidth: cellWidth)
    }
    //用于值显示
    convenience init(functionValueText: String?,
                     textColor: TextColor? = .ox666666,
                     textFont: TextFont? = .regular(size: 16),
                     textAlignment: NSTextAlignment? = nil,
                     leftSpace: CGFloat? = VLScaleWidth(20),
                     rightSpace: CGFloat? = -VLScaleWidth(20)) {
        self.init(text: functionValueText,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  textAlignment: textAlignment,
                  leftSpace: leftSpace,
                  rightSpace: rightSpace)
    }
    //文字提示(用于提示语)
    convenience init(hintText: String?,
                     textColor: TextColor? = .ox666666,
                     textFont: TextFont? = .regular(size: 15),
                     textAlignment: NSTextAlignment? = nil,
                     leftSpace: CGFloat? = VLScaleWidth(20),
                     rightSpace: CGFloat? = -VLScaleWidth(20)) {
        self.init(text: hintText,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  textAlignment: textAlignment,
                  leftSpace: leftSpace,
                  rightSpace: rightSpace)
    }
    
    //文字提示(用于提示语)
    convenience init(lightHintText: String?,
                     textColor: TextColor? = .ox999999,
                     textFont: TextFont? = .regular(size: 14),
                     textAlignment: NSTextAlignment? = nil,
                     viewBGColor: UIColor? = nil,
                     leftSpace: CGFloat? = VLScaleWidth(20),
                     rightSpace: CGFloat? = -VLScaleWidth(20)) {
        self.init(text: lightHintText,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  textAlignment: textAlignment,
                  viewBGColor: viewBGColor,
                  leftSpace: leftSpace,
                  rightSpace: rightSpace)
    }
    //文字提示(用于功能提示)
    convenience init(functionHintText: String?,
                     textColor: TextColor? = .ox666666,
                     textFont: TextFont? = .regular(size: 14),
                     textAlignment: NSTextAlignment? = nil) {
        self.init(text: functionHintText,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  textAlignment: textAlignment,
                  leftSpace: VLScaleWidth(20),
                  rightSpace: -VLScaleWidth(20))
    }
    //错误红色提示:默认top间距是8
    convenience init(errorHintText: String?,
                     textColor: TextColor? = .oxFA584D,
                     textFont: TextFont? = .regular(size: 12),
                     topSpace: CGFloat? = VLScaleHeight(8)) {
        self.init(text: errorHintText,
                  textColor: textColor?.color(),
                  textFont: textFont?.font(),
                  leftSpace: VLScaleWidth(20),
                  rightSpace: -VLScaleWidth(20),
                  topSpace: topSpace)
    }
    
    func update(errorHintText: String?) {
        self.update(text: errorHintText,
                    textColor: TextColor.oxFA584D.color())
    }
    
    func update(lightHintText: String?) {
        self.update(text: lightHintText,
                    textColor: TextColor.ox999999.color())
    }
}
