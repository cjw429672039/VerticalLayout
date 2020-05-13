//
//  ButtonItemViewModel+Extension.swift
//  
//
//  Created by HarveyChen on 2020/4/20.
//  Copyright © 2020 . All rights reserved.
//

import Foundation

extension ButtonItemViewModel {
    convenience init(onlyText: String) {
        let width = NSAttributedString(string: onlyText,
                                       textColor: TextColor.ox00C389.color(),
                                       font: TextFont.regular(size: 14).font()).size().width
        self.init(text: onlyText,
                  enableTextColor: TextColor.ox00C389.color(),
                  enableTextFont: TextFont.regular(size: 14).font(),
                  alignment: .right,
                  textLine: true,
                  leftSpace: VLScreenW - VLScaleWidth(30) - width,
                  rightSpace: -VLScaleWidth(20))
    }
    /// tableView上item: 绿色背景白色文字按钮
    convenience init(greenBGWhiteText: String?,
                     enable: Bool = true,
                     loading: Bool = false,
                     leftRightSpace: CGFloat = VLScaleWidth(20)) {
        self.init(text: greenBGWhiteText,
                  enableTextColor: TextColor.oxFFFFFF.color(),
                  enableTextFont: TextFont.medium(size: 16).font(),
                  enableBtnBgColor: TextColor.ox00C389.color(),
                  disableBtnBgColor: TextColor.oxBBBBBB.color(),
                  loading: loading,
                  leftSpace: leftRightSpace,
                  rightSpace: -leftRightSpace,
                  buttonHeight: VLScaleHeight(44),
                  enable: enable)
    }
    /// tableView上item:灰色背景绿色字体
    convenience init(grayBGGreenText: String?, enable: Bool = true, leftRightSpace: CGFloat = VLScaleWidth(20)) {
        self.init(text: grayBGGreenText,
                  enableTextColor: TextColor.ox00C389.color(),
                  disableTextFont: TextFont.medium(size: 16).font(),
                  enableBtnBgColor: TextColor.oxF1F1F1.color(),
                  disableBtnBgColor: TextColor.oxBBBBBB.color(),
                  leftSpace: leftRightSpace,
                  rightSpace: -leftRightSpace,
                  buttonHeight: VLScaleHeight(44),
                  enable: enable)
    }
    /// tableView上item:白色背景黑色字体
    convenience init(whiteBGBlackText: String?) {
        self.init(text: whiteBGBlackText,
                  enableTextColor: TextColor.ox333333.color(),
                  enableTextFont: TextFont.medium(size: 16).font(),
                  enableBtnBgColor: TextColor.oxFFFFFF.color(),
                  cellBgColor: .clear,
                  leftSpace: VLScaleWidth(16),
                  rightSpace: -VLScaleWidth(16),
                  buttonHeight: VLScaleHeight(44))
    }
    /// tableView上item:白色背景黑色字体
    convenience init(whiteBGRedText: String?) {
        self.init(text: whiteBGRedText,
                  enableTextColor: TextColor.oxFA584D.color(),
                  enableTextFont: TextFont.medium(size: 16).font(),
                  enableBtnBgColor: TextColor.oxFFFFFF.color(),
                  cellBgColor: .clear,
                  leftSpace: VLScaleWidth(16),
                  rightSpace: -VLScaleWidth(16),
                  buttonHeight: VLScaleHeight(44))
    }
    /// 底部绿色背景白色文字按钮
    convenience init(greenBGWhiteTextBottom: String?, enable: Bool = true, leftRightSpace: CGFloat = VLScaleWidth(16)) {
        self.init(text: greenBGWhiteTextBottom,
                  enableTextColor: TextColor.oxFFFFFF.color(),
                  disableTextFont: TextFont.medium(size: 16).font(),
                  enableBtnBgColor: TextColor.ox00C389.color(),
                  disableBtnBgColor: TextColor.oxBBBBBB.color(),
                  cellBgColor: TextColor.oxFFFFFF.color(),
                  leftSpace: leftRightSpace,
                  rightSpace: -leftRightSpace,
                  topSpace: VLScaleHeight(16),
                  bottomSpace: -(VLIsIPhoneX() ? VLIPhoneXBottomH : VLScaleHeight(16)),
                  buttonHeight: VLScaleHeight(44),
                  enable: enable)
    }
    ///底部灰色背景红色色文字按钮
    convenience init(grayBGRedTextBottom: String?) {
        self.init(text: grayBGRedTextBottom,
                  enableTextColor: TextColor.oxFA584D.color(),
                  enableTextFont: TextFont.medium(size: 16).font(),
                  enableBtnBgColor: TextColor.oxF1F1F1.color(),
                  cellBgColor: TextColor.oxFFFFFF.color(),
                  leftSpace: VLScaleWidth(20),
                  rightSpace: -VLScaleWidth(20),
                  topSpace: VLScaleHeight(16),
                  bottomSpace: -(VLIsIPhoneX() ? VLIPhoneXBottomH : VLScaleHeight(16)),
                  buttonHeight: VLScaleHeight(44))
    }
    ///左侧菜单栏按钮
    convenience init(leftMenu: String?) {
        self.init(text: leftMenu,
                  enableTextColor: TextColor.oxFA584D.color(),
                  enableTextFont: TextFont.medium(size: 16).font(),
                  enableBtnBgColor: TextColor.oxF1F1F1.color(),
                  cellBgColor: TextColor.oxFFFFFF.color(),
                  leftSpace: VLScaleWidth(44),
                  rightSpace: -VLScaleWidth(44),
                  buttonHeight: VLScaleHeight(44))
    }
    /// 底部白色背景绿色文字下划线按钮
    convenience init(whiteBGGreenTextBottom: String?, enable: Bool = true, leftRightSpace: CGFloat = VLScaleWidth(20)) {
        self.init(text: whiteBGGreenTextBottom,
                  enableTextColor: TextColor.ox00C389.color(),
                  enableTextFont: TextFont.regular(size: 14).font(),
                  enableBtnBgColor: TextColor.oxFFFFFF.color(),
                  cellBgColor: TextColor.oxFFFFFF.color(),
                  textLine: true,
                  leftSpace: leftRightSpace,
                  rightSpace: -leftRightSpace,
                  buttonHeight: VLScaleHeight(44),
                  enable: enable)
    }
}
