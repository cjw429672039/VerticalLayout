//
//  Const.swift
//  
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
let VLScreenBounds = UIScreen.main.bounds
let VLScreenScale = UIScreen.main.scale
let VLScreenSize = VLScreenBounds.size
//当前屏幕分辨率
let VLScreenW = VLScreenSize.width
let VLScreenH = VLScreenSize.height
let VLNavBarItemMargin: CGFloat = 20.0
//当前UI设计尺寸基础为
let VLIPhone = VLIPhoneKind.iPhone6
let VLIPhoneUIWidth: CGFloat = VLIPhones[VLIPhone]!.width
let VLIPhoneUIHeight: CGFloat = VLIPhones[VLIPhone]!.height
//适配常用宏
let VLUseWidth: CGFloat = (VLScreenW > VLIPhoneUIWidth ? VLIPhoneUIWidth : VLScreenW)
let VLUseHeight: CGFloat = (VLScreenH > VLIPhoneUIHeight ? VLIPhoneUIHeight : VLScreenH)
//状态栏高度
let VLStatusbarH: CGFloat = VLIsIPhoneX() ? 44.0 : 20.0
//导航bar高度
let VLNavigationBarHeight: CGFloat = 44.0
//整体导航栏高度（状态栏+bar）
let VLNavibarH: CGFloat = VLStatusbarH + VLNavigationBarHeight
//电池高度
let VLBatteryH: CGFloat = VLIsIPhoneX() ? 24.0 : 20.0
//tabbar高度
let VLTabbarH: CGFloat = VLIsIPhoneX() ? 49.0 + 34.0 : 49.0
let VLBottomAddHeight: CGFloat = VLIsIPhoneX() ? 34.0 : 0
let VLIPhoneXBottomH: CGFloat = 34.0
let VLIPhoneXTopH: CGFloat = 24.0

// MARK: - 常用字体
@inline(__always) func VLSystemRegularFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? VLScaleWidth(size) : size
    let font = UIFont.systemFont(ofSize: fontSize)
    return font
}

@inline(__always) func VLSystemBoldFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? VLScaleWidth(size) : size
    let font = UIFont.boldSystemFont(ofSize: fontSize)
    return font
}

@inline(__always) func VLSystemMediumFont(_ size: CGFloat, isScale: Bool = true) -> UIFont {
    let fontSize = isScale ? VLScaleWidth(size) : size
    let font = UIFont.init(name: "PingFangSC-Medium", size: fontSize)!
    return font
}

// MARK: - 等比例适配宏
@inline(__always) func VLScaleWidth(_ width: CGFloat) -> CGFloat {
    return width * VLUseWidth / VLIPhoneUIWidth
}

@inline(__always) func VLScaleHeight(_ height: CGFloat) -> CGFloat {
    return height * VLUseHeight / VLIPhoneUIHeight
}
//判断手机是否是iPhoneX
@inline(__always) func VLIsIPhoneX() -> Bool {
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
@inline(__always) func VLRGBA(_ rValue: CGFloat, _ gValue: CGFloat, _ bValue: CGFloat, _ aValue: CGFloat) -> UIColor {
    
    return UIColor(red: rValue/255.0, green: gValue/255.0, blue: bValue/255.0, alpha: aValue)
}

@inline(__always) func VLHexColor(_ hexColor: Int64, alpha: CGFloat = 1) -> UIColor {
    let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0
    let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0
    let blue = ((CGFloat)(hexColor & 0xFF))/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

@inline(__always) func isVLIPhoneKind(phoneKind: VLIPhoneKind) -> Bool {
    let phoneSize = VLIPhones[phoneKind]
    if CGFloat(phoneSize?.width ?? 0) == VLScreenW {
        return true
    }
    return false
}
//苹果历代iPhone机型
enum VLIPhoneKind: Int {
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
let VLIPhones: [VLIPhoneKind: (width: CGFloat, height: CGFloat)] =
    [VLIPhoneKind.iPhone4: (320.0, 480.0),
     VLIPhoneKind.iPhone4S: (320.0, 480.0),
     VLIPhoneKind.iPhone5: (320.0, 568.0),
     VLIPhoneKind.iPhone5c: (320.0, 568.0),
     VLIPhoneKind.iPhone5S: (320.0, 568.0),
     VLIPhoneKind.iPhoneSE: (320.0, 568.0),
     VLIPhoneKind.iPhone6: (375.0, 667.0),
     VLIPhoneKind.iPhone6S: (375.0, 667.0),
     VLIPhoneKind.iPhone7: (375.0, 667.0),
     VLIPhoneKind.iPhone8: (375.0, 667.0),
     VLIPhoneKind.iPhoneX: (375.0, 812.0),
     VLIPhoneKind.iPhoneXS: (375.0, 812.0),
     VLIPhoneKind.iPhone11Pro: (375.0, 812.0),
     VLIPhoneKind.iPhone6P: (414.0, 736.0),
     VLIPhoneKind.iPhone6SP: (414.0, 736.0),
     VLIPhoneKind.iPhone7P: (414.0, 736.0),
     VLIPhoneKind.iPhone8P: (414.0, 736.0),
     VLIPhoneKind.iPhoneXR: (414.0, 896.0),
     VLIPhoneKind.iPhoneXSMax: (414.0, 896.0),
     VLIPhoneKind.iPhone11: (414.0, 896.0),
     VLIPhoneKind.iPhone11ProMax: (414.0, 896.0)]
