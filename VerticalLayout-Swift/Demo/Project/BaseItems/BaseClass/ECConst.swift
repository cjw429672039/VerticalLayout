//
//  Const.swift
//  Assureapt
//
//  Created by Sheldon on 2019/8/7.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit

// MARK: - Siwft全局第三方常用库引用
@_exported import RxSwift
@_exported import RxCocoa
@_exported import SnapKit

// MARK: - 常用尺寸
let ECScreenBounds = UIScreen.main.bounds
let ECScreenScale = UIScreen.main.scale
let ECScreenSize = ECScreenBounds.size
//当前屏幕分辨率
let ECScreenW = ECScreenSize.width
let ECScreenH = ECScreenSize.height
let ECNavBarItemMargin: CGFloat = 20.0
//当前UI设计尺寸基础为
let ECIPhone = ECIPhoneKind.iPhone6
let ECIPhoneUIWidth: CGFloat = ECIPhones[ECIPhone]!.width
let ECIPhoneUIHeight: CGFloat = ECIPhones[ECIPhone]!.height
//适配常用宏
let ECUseWidth: CGFloat = (ECScreenW > ECIPhoneUIWidth ? ECIPhoneUIWidth : ECScreenW)
let ECUseHeight: CGFloat = (ECScreenH > ECIPhoneUIHeight ? ECIPhoneUIHeight : ECScreenH)
//状态栏高度
let ECStatusbarH: CGFloat = ECIsIPhoneX() ? 44.0 : 20.0
//导航bar高度
let ECNavigationBarHeight: CGFloat = 44.0
//整体导航栏高度（状态栏+bar）
let ECNavibarH: CGFloat = ECStatusbarH + ECNavigationBarHeight
//电池高度
let ECBatteryH: CGFloat = ECIsIPhoneX() ? 24.0 : 20.0
//tabbar高度
let ECTabbarH: CGFloat = ECIsIPhoneX() ? 49.0 + 34.0 : 49.0
let ECBottomAddHeight: CGFloat = ECIsIPhoneX() ? 34.0 : 0
let ECIPhoneXBottomH: CGFloat = 34.0
let ECIPhoneXTopH: CGFloat = 24.0

// MARK: - 常用字体
@inline(__always) func ECSystemRegularFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? ECScaleWidth(size) : size
    let font = UIFont.systemFont(ofSize: fontSize)
    return font
}

@inline(__always) func ECSystemBoldFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? ECScaleWidth(size) : size
    let font = UIFont.boldSystemFont(ofSize: fontSize)
    return font
}

@inline(__always) func ECSystemMediumFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? ECScaleWidth(size) : size
    let font = UIFont.init(name: "PingFangSC-Medium", size: fontSize)!
    return font
}

// MARK: - 等比例适配宏
@inline(__always) func ECScaleWidth(_ width: CGFloat) -> CGFloat {
    return width * ECUseWidth / ECIPhoneUIWidth
}

@inline(__always) func ECScaleHeight(_ height: CGFloat) -> CGFloat {
    return height * ECUseHeight / ECIPhoneUIHeight
}
//判断手机是否是iPhoneX
@inline(__always) func ECIsIPhoneX() -> Bool {
    if #available(iOS 11.0, *) {
        if UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20.0 > CGFloat(20.0) {
            return true
        } else {
            return false
        }
    } else {
        return false
    }
}
// MARK: - 颜色方法
@inline(__always) func ECRGBA(_ rValue: CGFloat, _ gValue: CGFloat, _ bValue: CGFloat, _ aValue: CGFloat) -> UIColor {
    
    return UIColor(red: rValue/255.0, green: gValue/255.0, blue: bValue/255.0, alpha: aValue)
}

@inline(__always) func ECHexColor(_ hexColor: Int64, alpha: CGFloat = 1) -> UIColor {
    let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0
    let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0
    let blue = ((CGFloat)(hexColor & 0xFF))/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

@inline(__always) func isECIPhoneKind(phoneKind: ECIPhoneKind) -> Bool {
    let phoneSize = ECIPhones[phoneKind]
    if CGFloat(phoneSize?.width ?? 0) == ECScreenW {
        return true
    }
    return false
}
//苹果历代iPhone机型
enum ECIPhoneKind: Int {
    case iPhone4 = 0,
    iPhone4S,
    iPhone5,
    iPhone5c,
    iPhone5S,
    iPhone6,
    iPhone6P,
    iPhone6S,
    iPhone6SP,
    iPhoneSE,
    iPhone7,
    iPhone7P,
    iPhone8,
    iPhone8P,
    iPhoneX,
    iPhoneXR,
    iPhoneXS,
    iPhoneXSMax,
    iPhone11,
    iPhone11Pro,
    iPhone11ProMax
}
//苹果历代iPhone机型尺寸
let ECIPhones: [ECIPhoneKind: (width: CGFloat, height: CGFloat)] =
    [ECIPhoneKind.iPhone4: (320.0, 480.0),
     ECIPhoneKind.iPhone4S: (320.0, 480.0),
     ECIPhoneKind.iPhone5: (320.0, 568.0),
     ECIPhoneKind.iPhone5c: (320.0, 568.0),
     ECIPhoneKind.iPhone5S: (320.0, 568.0),
     ECIPhoneKind.iPhoneSE: (320.0, 568.0),
     ECIPhoneKind.iPhone6: (375.0, 667.0),
     ECIPhoneKind.iPhone6S: (375.0, 667.0),
     ECIPhoneKind.iPhone7: (375.0, 667.0),
     ECIPhoneKind.iPhone8: (375.0, 667.0),
     ECIPhoneKind.iPhoneX: (375.0, 812.0),
     ECIPhoneKind.iPhoneXS: (375.0, 812.0),
     ECIPhoneKind.iPhone11Pro: (375.0, 812.0),
     ECIPhoneKind.iPhone6P: (414.0, 736.0),
     ECIPhoneKind.iPhone6SP: (414.0, 736.0),
     ECIPhoneKind.iPhone7P: (414.0, 736.0),
     ECIPhoneKind.iPhone8P: (414.0, 736.0),
     ECIPhoneKind.iPhoneXR: (414.0, 896.0),
     ECIPhoneKind.iPhoneXSMax: (414.0, 896.0),
     ECIPhoneKind.iPhone11: (414.0, 896.0),
     ECIPhoneKind.iPhone11ProMax: (414.0, 896.0)]
