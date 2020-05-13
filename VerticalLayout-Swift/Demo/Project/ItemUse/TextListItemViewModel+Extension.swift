//
//  TextListItemViewModel.swift
//  
//
//  Created by HarveyChen on 2020/4/20.
//  Copyright © 2020 . All rights reserved.
//

import Foundation

extension TextListItemViewModel {
    /*
     ------------------------------
     text                         >
     ------------------------------
     */
    convenience init(leftText: String? = nil,
                     line: Bool = false,
                     arrow: Bool = false,
                     selectType: SelectType? = nil) {
        self.init(style: .leftText(leftLabelLeftSpace: VLScaleWidth(16), leftLabelRightSpace: -VLScaleWidth(16)),
                  leftText: leftText,
                  leftTextColor: TextColor.ox333333.color(),
                  leftTextFont: TextFont.regular(size: 16).font(),
                  arrowImage: UIImage(named: "iconArrow02"),
                  line: line,
                  arrow: arrow,
                  selectType: selectType)
    }
    /*
    ------------------------------
    image text                   >
    ------------------------------
    */
    convenience init(leftImageText: String? = nil,
                     leftImageString: String? = nil,
                     leftPlaceImage: UIImage? = nil,
                     line: Bool = false,
                     arrow: Bool = false,
                     selectType: SelectType? = nil) {
        self.init(style: .leftImageText(leftImageLeftSpace: VLScaleWidth(16),
                                        leftLabelLeftSpace: VLScaleWidth(12),
                                        leftLabelRightSpace: -VLScaleWidth(16)),
                  leftImageString: leftImageString,
                  leftPlaceImage: leftPlaceImage,
                  leftText: leftImageText,
                  leftTextColor: TextColor.ox333333.color(),
                  leftTextFont: TextFont.regular(size: 16).font(),
                  arrowImage: UIImage(named: "iconArrow02"),
                  line: line,
                  arrow: arrow,
                  selectType: selectType)
    }
    
    convenience init(leftMenu: String? = nil,
                     leftPlaceImage: UIImage? = nil,
                     selectType: SelectType? = nil) {
        self.init(style: .leftImageText(leftImageLeftSpace: VLScaleWidth(16),
                                        leftLabelLeftSpace: VLScaleWidth(12),
                                        leftLabelRightSpace: -VLScaleWidth(12)),
                  leftPlaceImage: leftPlaceImage,
                  leftText: leftMenu,
                  leftTextColor: TextColor.ox333333.color(),
                  leftTextFont: TextFont.regular(size: 16).font(),
                  arrowImage: UIImage(named: "iconArrow02"),
                  arrow: true,
                  selectType: selectType,
                  height: VLScaleHeight(60))
        statusUpdate(rightArrowLayout: (-VLScaleWidth(24), UIImage(named: "iconArrow02")!.size))
    }
    /*
     ------------------------------
     text                     text>
     ------------------------------
     */
    convenience init(leftTextRightText: String? = nil,
                     rightText: String? = nil,
                     rightTextColor: TextColor = .ox999999,
                     rightTextFont: TextFont = .regular(size: 16),
                     line: Bool = false,
                     arrow: Bool = false,
                     selectType: SelectType? = nil,
                     height: CGFloat? = nil) {
        self.init(style: .leftTextRightText(leftLabelLeftSpace: VLScaleWidth(16),
                                            rightLabelRightSpace: -VLScaleWidth(8),
                                            rightLabelMaxWidth: VLScaleWidth(100),
                                            leftRightSpace: VLScaleWidth(12)),
                  leftText: leftTextRightText,
                  leftTextColor: TextColor.ox333333.color(),
                  leftTextFont: TextFont.regular(size: 16).font(),
                  rightText: rightText,
                  rightTextColor: rightTextColor.color(),
                  rightTextFont: rightTextFont.font(),
                  arrowImage: UIImage(named: "iconArrow02"),
                  line: line,
                  arrow: arrow,
                  selectType: selectType,
                  height: height)
    }
    /*
    ------------------------------
    text                    image>
    ------------------------------
    */
    convenience init(leftTextRightImage: String? = nil,
                     rightImageString: String? = nil,
                     rightPlaceImage: UIImage? = nil,
                     line: Bool = false,
                     arrow: Bool = false,
                     selectType: SelectType? = nil) {
        self.init(style: .leftTextRightImage(leftLabelLeftSpace: VLScaleWidth(16),
                                             leftLabelRightSpace: -VLScaleWidth(12),
                                             rightImageRightSpace: -VLScaleWidth(8)),
                  leftText: leftTextRightImage,
                  leftTextColor: TextColor.ox333333.color(),
                  leftTextFont: TextFont.regular(size: 16).font(),
                  rightImageString: rightImageString,
                  rightPlaceImage: rightPlaceImage,
                  arrowImage: UIImage(named: "iconArrow02"),
                  line: line,
                  arrow: arrow,
                  selectType: selectType)
    }
    /*
    ------------------------------
    image text              image>
    ------------------------------
    */
    convenience init(leftImageTextRightImage: String? = nil,
                     rightImageString: String? = nil,
                     rightPlaceImage: UIImage? = nil,
                     rightImageSize: CGSize? = nil,
                     line: Bool = false,
                     arrow: Bool = false,
                     selectType: SelectType? = nil) {
        self.init(style: .leftImageTextRightImage(leftImageLeftSpace: VLScaleWidth(16),
                                                  leftLabelLeftSpace: VLScaleWidth(12),
                                                  leftLabelRightSpace: -VLScaleWidth(12),
                                                  rightImageRightSpace: -VLScaleWidth(8)),
                  leftText: leftImageTextRightImage,
                  leftTextColor: TextColor.ox333333.color(),
                  leftTextFont: TextFont.regular(size: 16).font(),
                  rightImageString: rightImageString,
                  rightPlaceImage: rightPlaceImage,
                  rightImageSize: rightImageSize,
                  arrowImage: UIImage(named: "iconArrow02"),
                  line: line,
                  arrow: arrow,
                  selectType: selectType)
    }
}
