//
//  TextListItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit

enum TextListStyle {
    /*
     ------------------------------
     text                         >
     ------------------------------
     */
    case leftText(leftLabelLeftSpace: CGFloat, leftLabelRightSpace: CGFloat)
    /*
     ------------------------------
     image                        >
     ------------------------------
     */
    case leftImage(leftImageLeftSpace: CGFloat)
    /*
     ------------------------------
     image text                   >
     ------------------------------
     */
    case leftImageText(leftImageLeftSpace: CGFloat, leftLabelLeftSpace: CGFloat, leftLabelRightSpace: CGFloat)
    /*
     ------------------------------
     text                     text>
     ------------------------------
     */
    case leftTextRightText(leftLabelLeftSpace: CGFloat, rightLabelRightSpace: CGFloat, rightLabelMaxWidth: CGFloat, leftRightSpace: CGFloat)
    /*
     ------------------------------
     text                    image>
     ------------------------------
     */
    case leftTextRightImage(leftLabelLeftSpace: CGFloat, leftLabelRightSpace: CGFloat, rightImageRightSpace: CGFloat)
    /*
     ------------------------------
     image text              image>
     ------------------------------
     */
    case leftImageTextRightImage(leftImageLeftSpace: CGFloat, leftLabelLeftSpace: CGFloat, leftLabelRightSpace: CGFloat, rightImageRightSpace: CGFloat)
}

/*
 样式包含
 左侧：图片，文字
 右侧：图片，文字，箭头
 底部：下划线
 */
class TextListItemViewModel: VLBaseItemViewModel {
    let leftImageRelay = BehaviorRelay<URL?>(value: nil)
    let leftPlaceImageRelay = BehaviorRelay<UIImage?>(value: nil)
    let leftTextRelay = BehaviorRelay<NSAttributedString?>(value: nil)
    let leftTextAlignment = BehaviorRelay<NSTextAlignment>(value: .left)
    let rightImageRelay = BehaviorRelay<URL?>(value: nil)
    let rightPlaceImageRelay = BehaviorRelay<UIImage?>(value: nil)
    let rightTextRelay = BehaviorRelay<NSAttributedString?>(value: nil)
    let rightTextAlignment = BehaviorRelay<NSTextAlignment>(value: .right)
    let viewBGColorRelay = BehaviorRelay<UIColor>(value: .white)
    let updateConstRelay = BehaviorRelay<Void>(value: ())
    let rightActiongRelay = PublishRelay<UITapGestureRecognizer>()
    let rightEnableRelay = BehaviorRelay<Bool>(value: false)
    
    var leftLabelLeftSpace = ECScaleWidth(16)
    var leftLabelRightSpace = ECScaleWidth(16)
    
    var leftImageLeftSpace = ECScaleWidth(16)
    var leftImageSize = CGSize(width: ECScaleHeight(24), height: ECScaleHeight(24))
    
    var rightLabelWidth = ECScaleWidth(0)
    var rightLabelRightSpace = ECScaleWidth(16)
    
    var rightImageRightSpace = ECScaleWidth(16)
    var rightImageSize = CGSize(width: ECScaleHeight(24), height: ECScaleHeight(24))
    
    var arrowImageRightSpace = -ECScaleWidth(16)
    var arrowImageSize = CGSize(width: ECScaleHeight(12), height: ECScaleHeight(12))
    
    private let leftSpaceRelay = BehaviorRelay<CGFloat>(value: ECScaleWidth(16))
    private let leftTextImageSpaceRelay = BehaviorRelay<CGFloat>(value: ECScaleWidth(12))
    private let rightSpaceRelay = BehaviorRelay<CGFloat>(value: ECScaleWidth(16))
    private let leftRightSpaceRelay = BehaviorRelay<CGFloat>(value: ECScaleWidth(12))
    
    private var leftTextColor: UIColor?
    private var leftTextFont: UIFont?
    private var leftText: String?
    private var rightTextColor: UIColor?
    private var rightTextFont: UIFont?
    private var rightText: String?
    private var style: TextListStyle?
    
    init(style: TextListStyle,
         leftImageString: String? = nil,
         leftPlaceImage: UIImage? = nil,
         leftImageSize: CGSize? = nil,
         leftText: String? = nil,
         leftTextColor: UIColor? = nil,
         leftTextFont: UIFont? = nil,
         rightImageString: String? = nil,
         rightPlaceImage: UIImage? = nil,
         rightImageSize: CGSize? = nil,
         rightText: String? = nil,
         rightTextColor: UIColor? = nil,
         rightTextFont: UIFont? = nil,
         rightEnable: Bool = false,
         viewBGColor: UIColor? = nil,
         arrowImage: UIImage? = nil,
         line: Bool = false,
         arrow: Bool = true,
         selectType: SelectType? = nil,
         height: CGFloat? = ECScaleHeight(60)) {
        super.init(itemSupportClassName: TextListTableViewCell.self, cellHeight: height ?? ECScaleHeight(60), selectType: selectType)
        
        self.update(style: style,
                    leftImageString: leftImageString,
                    leftPlaceImage: leftPlaceImage,
                    leftText: leftText,
                    leftTextColor: leftTextColor,
                    leftTextFont: leftTextFont,
                    rightImageString: rightImageString,
                    rightPlaceImage: rightPlaceImage,
                    rightText: rightText,
                    rightTextColor: rightTextColor,
                    rightTextFont: rightTextFont,
                    rightEnable: rightEnable,
                    viewBGColor: viewBGColor,
                    arrowImage: arrowImage,
                    line: line,
                    arrow: arrow,
                    selectType: selectType)
    }
}

extension TextListItemViewModel {
    func update(style: TextListStyle? = nil,
                leftImageString: String? = nil,
                leftPlaceImage: UIImage? = nil,
                leftImageSize: CGSize? = nil,
                leftText: String? = nil,
                leftTextColor: UIColor? = nil,
                leftTextFont: UIFont? = nil,
                rightImageString: String? = nil,
                rightPlaceImage: UIImage? = nil,
                rightImageSize: CGSize? = nil,
                rightText: String? = nil,
                rightTextColor: UIColor? = nil,
                rightTextFont: UIFont? = nil,
                rightEnable: Bool? = nil,
                viewBGColor: UIColor? = nil,
                arrowImage: UIImage? = nil,
                line: Bool? = nil,
                arrow: Bool? = nil,
                selectType: SelectType? = nil,
                height: CGFloat? = nil) {
        if let style = style {
            self.style = style
        }
        
        if let leftText = leftText {
            self.leftText = leftText
        }
        
        if let leftTextColor = leftTextColor {
            self.leftTextColor = leftTextColor
        }
        
        if let leftTextFont = leftTextFont {
            self.leftTextFont = leftTextFont
        }
        
        if let rightText = rightText {
            self.rightText = rightText
        }
        
        if let rightTextColor = rightTextColor {
            self.rightTextColor = rightTextColor
        }
        
        if let rightTextFont = rightTextFont {
            self.rightTextFont = rightTextFont
        }
        
        if let leftPlaceImage = leftPlaceImage {
            self.leftPlaceImageRelay.accept(leftPlaceImage)
            self.leftImageSize = CGSize(width: ECScaleHeight(leftPlaceImage.size.width), height: ECScaleHeight(leftPlaceImage.size.height))
        }
        
        if let leftImageSize = leftImageSize {
            self.leftImageSize = leftImageSize
        }
        
        if let rightImageSize = rightImageSize {
            self.rightImageSize = rightImageSize
        }
        
        if let leftImageString = leftImageString {
            self.leftImageRelay.accept(URL(string: leftImageString))
        }
        
        if let rightPlaceImage = rightPlaceImage {
            self.rightPlaceImageRelay.accept(rightPlaceImage)
            self.rightImageSize = CGSize(width: ECScaleHeight(rightPlaceImage.size.width), height: ECScaleHeight(rightPlaceImage.size.height))
        }
        
        if let rightEnable = rightEnable {
            self.rightEnableRelay.accept(rightEnable)
        }
        
        if let viewBGColor = viewBGColor {
            self.viewBGColorRelay.accept(viewBGColor)
        }
        
        if let line = line {
            self.lineRelay.accept(line)
        }
        
        if let arrow = arrow {
            self.rightArrowRelay.accept(arrow)
        }
        
        if let arrowImage = arrowImage {
            self.rightArrowImageRelay.accept(arrowImage)
        }
        
        if let selectType = selectType {
            self.selectTypeRelay.accept(selectType)
        }
        
        if let height = height {
            self.cellHeight = height
        }
        
        self.leftTextRelay.accept(self.attString(text: self.leftText, textColor: self.leftTextColor, textFont: self.leftTextFont))
        self.rightTextRelay.accept(self.attString(text: self.rightText, textColor: self.rightTextColor, textFont: self.rightTextFont))
        
        switch (self.style ?? TextListStyle.leftText(leftLabelLeftSpace: ECScaleWidth(16), leftLabelRightSpace: -ECScaleWidth(16))) {
        case let .leftText(leftLabelLeftSpace,
                           leftLabelRightSpace):
            let leftLabelRightSpace = self.rightArrowRelay.value ? -self.arrowImageSize.width + self.arrowImageRightSpace + leftLabelRightSpace : self.arrowImageRightSpace
            self.updateConstraints(leftLabelLeftSpace: leftLabelLeftSpace, leftLabelRightSpace: leftLabelRightSpace)
        case let .leftImage(leftImageLeftSpace):
            self.updateConstraints(leftImageLeftSpace: leftImageLeftSpace,
                                   leftImageSize: self.leftImageSize)
        case let .leftImageText(leftImageLeftSpace,
                                leftLabelLeftSpace,
                                leftLabelRightSpace):
            let leftLabelLeftSpace = leftImageLeftSpace + self.leftImageSize.width + leftLabelLeftSpace
            let leftLabelRightSpace = self.rightArrowRelay.value ? -self.arrowImageSize.width + self.arrowImageRightSpace + leftLabelRightSpace : self.arrowImageRightSpace
            self.updateConstraints(leftLabelLeftSpace: leftLabelLeftSpace,
                                   leftLabelRightSpace: leftLabelRightSpace,
                                   leftImageLeftSpace: leftImageLeftSpace,
                                   leftImageSize: self.leftImageSize)
        case let .leftTextRightText(leftLabelLeftSpace,
                                    rightLabelRightSpace,
                                    rightLabelMaxWidth,
                                    leftRightSpace):
            let rightLabelRightSpace = self.rightArrowRelay.value ? -self.arrowImageSize.width + self.arrowImageRightSpace + rightLabelRightSpace : self.arrowImageRightSpace
            let leftLabelRightSpace = rightLabelRightSpace - rightLabelMaxWidth - leftRightSpace
            self.updateConstraints(leftLabelLeftSpace: leftLabelLeftSpace,
                                   leftLabelRightSpace: leftLabelRightSpace,
                                   rightLabelWidth: rightLabelMaxWidth,
                                   rightLabelRightSpace: rightLabelRightSpace)
        case let .leftTextRightImage(leftLabelLeftSpace,
                                     leftLabelRightSpace,
                                     rightImageRightSpace):
            let rightImageRightSpace = self.rightArrowRelay.value ? -self.arrowImageSize.width + self.arrowImageRightSpace + rightImageRightSpace : self.arrowImageRightSpace
            let leftLabelRightSpace = rightImageRightSpace - self.rightImageSize.width + leftLabelRightSpace
            self.updateConstraints(leftLabelLeftSpace: leftLabelLeftSpace,
                                   leftLabelRightSpace: leftLabelRightSpace,
                                   rightImageSize: self.rightImageSize,
                                   rightImageRightSpace: rightImageRightSpace)
        case let .leftImageTextRightImage(leftImageLeftSpace,
                                          leftLabelLeftSpace,
                                          leftLabelRightSpace,
                                          rightImageRightSpace):
            let rightImageRightSpace = self.rightArrowRelay.value ? -self.arrowImageSize.width + self.arrowImageRightSpace + rightImageRightSpace : self.arrowImageRightSpace
            let leftLabelLeftSpace = leftImageLeftSpace + self.leftImageSize.width + leftLabelLeftSpace
            let leftLabelRightSpace = rightImageRightSpace - self.rightImageSize.width + leftLabelRightSpace
            self.updateConstraints(leftLabelLeftSpace: leftLabelLeftSpace,
                                   leftLabelRightSpace: leftLabelRightSpace,
                                   leftImageLeftSpace: leftImageLeftSpace,
                                   leftImageSize: self.leftImageSize,
                                   rightImageSize: self.rightImageSize,
                                   rightImageRightSpace: rightImageRightSpace)
        }
        self.updateConstRelay.accept(())
    }
    
    private func updateConstraints(leftLabelLeftSpace: CGFloat = 0,
                                   leftLabelRightSpace: CGFloat = 0,
                                   leftImageLeftSpace: CGFloat = 0,
                                   leftImageSize: CGSize = CGSize(width: 0, height: 0),
                                   rightLabelWidth: CGFloat = 0,
                                   rightLabelRightSpace: CGFloat = 0,
                                   rightImageSize: CGSize = CGSize(width: 0, height: 0),
                                   rightImageRightSpace: CGFloat = 0) {
        self.leftLabelLeftSpace = leftLabelLeftSpace
        self.leftLabelRightSpace = leftLabelRightSpace
        self.leftImageLeftSpace = leftImageLeftSpace
        self.leftImageSize = leftImageSize
        self.rightLabelRightSpace = rightLabelRightSpace
        self.rightLabelWidth = rightLabelWidth
        self.rightImageSize = rightImageSize
        self.rightImageRightSpace = rightImageRightSpace
    }
    
    private func attString(text: String?, textColor: UIColor?, textFont: UIFont?) -> NSAttributedString {
        return NSAttributedString(ecString: text ?? "",
                                  textColor: textColor ?? ECHexColor(0x999999),
                                  font: textFont ?? ECSystemRegularFont(15))
    }
}
