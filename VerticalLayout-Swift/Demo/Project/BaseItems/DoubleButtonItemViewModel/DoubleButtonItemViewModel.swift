//
//  DoubleButtonItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit
import RxRelay

typealias LeftButtonLayoutFrame = (leftSapce: CGFloat, width: CGFloat)
typealias RightButtonLayoutFrame = (leftSapce: CGFloat, rightSpace: CGFloat)

class DoubleButtonItemViewModel: VLBaseItemViewModel {
    let leftAttTextRelay = BehaviorRelay<NSAttributedString?>(value: nil)
    let leftImageRelay = BehaviorRelay<UIImage?>(value: nil)
    let leftButtonBGColorRelay = BehaviorRelay<UIColor>(value: .clear)
    let leftButtonAction = PublishRelay<Void>()
    let leftButtonAlignment = BehaviorRelay<UIControl.ContentHorizontalAlignment>(value: .left)
    let rightAttTextRelay = BehaviorRelay<NSAttributedString?>(value: nil)
    let rightImageRelay = BehaviorRelay<UIImage?>(value: nil)
    let rightButtonBGColorRelay = BehaviorRelay<UIColor>(value: .clear)
    let rightButtonAction = PublishRelay<Void>()
    let rightButtonAlignment = BehaviorRelay<UIControl.ContentHorizontalAlignment>(value: .right)
    var leftButtonLayout: LeftButtonLayoutFrame = (0, 0)
    var rightButtonLayout: RightButtonLayoutFrame = (0, 0)
    let updateConstRelay = BehaviorRelay<Void>(value: ())
    
    private var leftText: String = ""
    private var leftTextColor: UIColor = ECHexColor(0x00C389)
    private var leftTextFont: UIFont = ECSystemRegularFont(14)
    private var leftTextLine: Bool = false
    private var leftButtonLeftSpace: CGFloat = ECScaleWidth(20)
    private var leftButtonWidth: CGFloat = ECScaleWidth((ECUseWidth - 40 - 16)/2)
    private var rightText: String = ""
    private var rightTextColor: UIColor = ECHexColor(0x00C389)
    private var rightTextFont: UIFont = ECSystemRegularFont(14)
    private var rightTextLine: Bool = false
    private var rightButtonLeftSpace: CGFloat = ECScaleWidth(20)
    private var rightButtonRightSpace: CGFloat = -ECScaleWidth(16)
    private var cellUseHeight: CGFloat?
     
    init(leftText: String? = nil,
         leftImage: UIImage? = nil,
         leftTextColor: UIColor? = nil,
         leftTextFont: UIFont? = nil,
         leftTextLine: Bool? = nil,
         leftTextAlignment: UIControl.ContentHorizontalAlignment? = nil,
         leftButtonBGColor: UIColor? = nil,
         leftButtonLeftSpace: CGFloat? = nil,
         leftButtonWidth: CGFloat? = nil,
         rightText: String? = nil,
         rightImage: UIImage? = nil,
         rightTextColor: UIColor? = nil,
         rightTextFont: UIFont? = nil,
         rightTextLine: Bool? = nil,
         rightTextAlignment: UIControl.ContentHorizontalAlignment? = nil,
         rightButtonBGColor: UIColor? = nil,
         rightButtonLeftSpace: CGFloat? = nil,
         rightButtonRightSpace: CGFloat? = nil,
         rightButtonWidth: CGFloat? = nil,
         height: CGFloat? = nil) {
        super.init(itemSupportClassName: DoubleButtonTableViewCell.self)
        
        self.update(leftText: leftText,
                    leftImage: leftImage,
                    leftTextColor: leftTextColor,
                    leftTextFont: leftTextFont,
                    leftTextLine: leftTextLine,
                    leftTextAlignment: leftTextAlignment,
                    leftButtonBGColor: leftButtonBGColor,
                    leftButtonLeftSpace: leftButtonLeftSpace,
                    leftButtonWidth: leftButtonWidth,
                    rightText: rightText,
                    rightImage: rightImage,
                    rightTextColor: rightTextColor,
                    rightTextFont: rightTextFont,
                    rightTextLine: rightTextLine,
                    rightTextAlignment: rightTextAlignment,
                    rightButtonBGColor: rightButtonBGColor,
                    rightButtonLeftSpace: rightButtonLeftSpace,
                    rightButtonRightSpace: rightButtonRightSpace,
                    rightButtonWidth: rightButtonWidth,
                    height: height)
    }
    
    func update(leftText: String? = nil,
                leftImage: UIImage? = nil,
                leftTextColor: UIColor? = nil,
                leftTextFont: UIFont? = nil,
                leftTextLine: Bool? = nil,
                leftTextAlignment: UIControl.ContentHorizontalAlignment? = nil,
                leftButtonBGColor: UIColor? = nil,
                leftButtonLeftSpace: CGFloat? = nil,
                leftButtonWidth: CGFloat? = nil,
                rightText: String? = nil,
                rightImage: UIImage? = nil,
                rightTextColor: UIColor? = nil,
                rightTextFont: UIFont? = nil,
                rightTextLine: Bool? = nil,
                rightTextAlignment: UIControl.ContentHorizontalAlignment? = nil,
                rightButtonBGColor: UIColor? = nil,
                rightButtonLeftSpace: CGFloat? = nil,
                rightButtonRightSpace: CGFloat? = nil,
                rightButtonWidth: CGFloat? = nil,
                height: CGFloat? = nil) {
        if let leftText = leftText {
            self.leftText = leftText
        }
        
        if let leftImage = leftImage {
            self.leftImageRelay.accept(leftImage)
        }
        
        if let leftTextColor = leftTextColor {
            self.leftTextColor = leftTextColor
        }
        
        if let leftTextFont = leftTextFont {
            self.leftTextFont = leftTextFont
        }
        
        if let leftTextLine = leftTextLine {
            self.leftTextLine = leftTextLine
        }
        
        if let leftTextAlignment = leftTextAlignment {
            self.leftButtonAlignment.accept(leftTextAlignment)
        }
        
        if let leftButtonBGColor = leftButtonBGColor {
            self.leftButtonBGColorRelay.accept(leftButtonBGColor)
        }
        
        if let leftButtonLeftSpace = leftButtonLeftSpace {
            self.leftButtonLeftSpace = leftButtonLeftSpace
        }
        
        if let leftButtonWidth = leftButtonWidth {
            self.leftButtonWidth = leftButtonWidth
        }
        
        if let rightText = rightText {
            self.rightText = rightText
        }
        
        if let rightImage = rightImage {
            self.rightImageRelay.accept(rightImage)
        }
        
        if let rightTextColor = rightTextColor {
            self.rightTextColor = rightTextColor
        }
        
        if let rightTextFont = rightTextFont {
            self.rightTextFont = rightTextFont
        }
        
        if let rightTextLine = rightTextLine {
            self.rightTextLine = rightTextLine
        }
        
        if let rightTextAlignment = rightTextAlignment {
            self.rightButtonAlignment.accept(rightTextAlignment)
        }
        
        if let rightButtonBGColor = rightButtonBGColor {
            self.rightButtonBGColorRelay.accept(rightButtonBGColor)
        }
        
        if let rightButtonLeftSpace = rightButtonLeftSpace {
            self.rightButtonLeftSpace = rightButtonLeftSpace
        }
        
        if let rightButtonRightSpace = rightButtonRightSpace {
            self.rightButtonRightSpace = rightButtonRightSpace
        }
        
        if let height = height {
            self.cellUseHeight = height
        }
        
        self.leftAttTextRelay.accept(NSAttributedString(ecString: self.leftText,
                                                        textColor: self.leftTextColor,
                                                        font: self.leftTextFont,
                                                        line: self.leftTextLine))
        self.rightAttTextRelay.accept(NSAttributedString(ecString: self.rightText,
                                                         textColor: self.rightTextColor,
                                                         font: self.rightTextFont,
                                                         line: self.rightTextLine))
        self.leftButtonLayout = (self.leftButtonLeftSpace, self.leftButtonWidth)
        self.rightButtonLayout = (self.rightButtonLeftSpace, self.rightButtonRightSpace)
        self.updateConstRelay.accept(())
        self.cellHeight = self.cellUseHeight ?? (self.leftAttTextRelay.value?.ecGetSize(width: self.leftButtonWidth).height ?? ECScaleHeight(18))
    }
}
