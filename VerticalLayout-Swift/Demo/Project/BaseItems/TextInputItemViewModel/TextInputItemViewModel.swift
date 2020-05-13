//
//  TextInputItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit

enum TextInputType {
    /*
     ------------------------------
     textField
     ------------------------------
     */
    case textField
    /*
     ------------------------------
     textField                image
     ------------------------------
    */
    case textFieldRightImage
    /*
     ------------------------------
     image textField
     ------------------------------
    */
    case leftImageTextField
    /*
     ------------------------------
     image textField          image
     ------------------------------
    */
    case leftImageTextFieldRightImage
}

class TextInputItemViewModel: VLBaseItemViewModel {
    let leftImageRelay: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    
    let placeHolderRelay: BehaviorRelay<NSAttributedString?> = BehaviorRelay(value: nil)
    let textColorRelay = BehaviorRelay<UIColor>(value: ECHexColor(0x333333))
    let textFontRelay = BehaviorRelay<UIFont>(value: ECSystemRegularFont(16))
    let textRelay: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let isPasswordRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let keyBoardTypeRelay: BehaviorRelay<UIKeyboardType> = BehaviorRelay(value: .default)
    let textFieldTinColorRelay: BehaviorRelay<UIColor> = BehaviorRelay(value: .gray)//光标线的颜色
    let textFieldEventRelay = PublishRelay<UIControl.Event>()
    let becomeFirstRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let rightImageRelay: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    let rightAction = PublishRelay<Void>()
    let updateConstRelay = BehaviorRelay<Void>(value: ())
    
    var leftImageConst: (CGFloat, CGSize) = (0, CGSize(width: 0, height: 0))
    var textFieldConst: (CGFloat, CGFloat) = (0, 0)
    var rightImageConst: (CGFloat, CGSize) = (0, CGSize(width: 0, height: 0))
    
    private var type = TextInputType.leftImageTextFieldRightImage
    private var textLength = 0//内容长度限制,0为不限制
    private var placeHolderString = ""
    private var placeHolderColor = ECHexColor(0xbbbbbb)
    private var placeHolderFont = VLSystemRegularFont(16)
    private var leftImageLeftSpace = ECScaleWidth(20)
    private var leftImageSize = CGSize(width: 0, height: 0)
    private var textFieldLeftSpace = ECScaleWidth(12)
    private var textFieldRightSpace = ECScaleWidth(12)
    private var rightImageRightSpace = -ECScaleWidth(20)
    private var rightImageSize = CGSize(width: 0, height: 0)
    
    init(type: TextInputType,
         leftImage: UIImage? = nil,
         leftImageLeftSpace: CGFloat? = nil,
         placeHolderString: String? = nil,
         placeHolderColor: UIColor? = nil,
         placeHolderFont: UIFont? = nil,
         text: String? = nil,
         textColor: UIColor? = nil,
         textFont: UIFont? = nil,
         password: Bool? = nil,
         keyboardType: UIKeyboardType? = nil,
         tinColor: UIColor? = nil,
         maxLength: Int? = nil,
         becomeFirst: Bool? = nil,
         textFieldLeftSpace: CGFloat? = nil,
         textFieldRightSpace: CGFloat? = nil,
         rightImage: UIImage? = nil,
         rightImageRightSpace: CGFloat? = nil,
         line: Bool? = nil,
         lineColor: UIColor? = nil,
         lineLayout: VLLineViewLayout? = nil,
         height: CGFloat? = nil) {
        super.init(itemSupportClassName: TextInputTableViewCell.self)
        self.update(type: type,
                    leftImage: leftImage,
                    leftImageLeftSpace: leftImageLeftSpace,
                    placeHolderString: placeHolderString,
                    placeHolderColor: placeHolderColor,
                    placeHolderFont: placeHolderFont,
                    text: text,
                    textColor: textColor,
                    textFont: textFont,
                    password: password,
                    keyboardType: keyboardType,
                    tinColor: tinColor,
                    maxLength: maxLength,
                    becomeFirst: becomeFirst,
                    textFieldLeftSpace: textFieldLeftSpace,
                    textFieldRightSpace: textFieldRightSpace,
                    rightImage: rightImage,
                    rightImageRightSpace: rightImageRightSpace,
                    line: line,
                    lineColor: lineColor,
                    lineLayout: lineLayout,
                    height: height)
    }
    
    func update(type: TextInputType? = nil,
                leftImage: UIImage? = nil,
                leftImageLeftSpace: CGFloat? = nil,
                placeHolderString: String? = nil,
                placeHolderColor: UIColor? = nil,
                placeHolderFont: UIFont? = nil,
                text: String? = nil,
                textColor: UIColor? = nil,
                textFont: UIFont? = nil,
                password: Bool? = nil,
                keyboardType: UIKeyboardType? = nil,
                tinColor: UIColor? = nil,
                maxLength: Int? = nil,
                becomeFirst: Bool? = nil,
                textFieldLeftSpace: CGFloat? = nil,
                textFieldRightSpace: CGFloat? = nil,
                rightImage: UIImage? = nil,
                rightImageRightSpace: CGFloat? = nil,
                line: Bool? = nil,
                lineColor: UIColor? = nil,
                lineLayout: VLLineViewLayout? = nil,
                height: CGFloat? = nil) {
        if let type = type {
            self.type = type
        }
        
        if let leftImage = leftImage {
            self.leftImageRelay.accept(leftImage)
            self.leftImageSize = CGSize(width: ECScaleHeight(leftImage.size.width), height: ECScaleHeight(leftImage.size.height))
        }
        
        if let leftImageLeftSpace = leftImageLeftSpace {
            self.leftImageLeftSpace = leftImageLeftSpace
        }
        
        if let placeHolderString = placeHolderString {
            self.placeHolderString = placeHolderString
        }
        
        if let placeHolderColor = placeHolderColor {
            self.placeHolderColor = placeHolderColor
        }
        
        if let placeHolderFont = placeHolderFont {
            self.placeHolderFont = placeHolderFont
        }
        
        if let text = text {
            self.textRelay.accept(text)
        }
        
        if let textColor = textColor {
            self.textColorRelay.accept(textColor)
        }
        
        if let textFont = textFont {
            self.textFontRelay.accept(textFont)
        }
        
        if let password = password {
            self.isPasswordRelay.accept(password)
        }
        
        if let keyboardType = keyboardType {
            self.keyBoardTypeRelay.accept(keyboardType)
        }
        
        if let tinColor = tinColor {
            self.textFieldTinColorRelay.accept(tinColor)
        }
        
        if let maxLength = maxLength {
            self.textLength = maxLength
        }
        
        if let becomeFirst = becomeFirst {
            self.becomeFirstRelay.accept(becomeFirst)
        }
        
        if let textFieldLeftSpace = textFieldLeftSpace {
            self.textFieldLeftSpace = textFieldLeftSpace
        }
        
        if let textFieldRightSpace = textFieldRightSpace {
            self.textFieldRightSpace = textFieldRightSpace
        }
        
        if let rightImage = rightImage {
            self.rightImageRelay.accept(rightImage)
            self.rightImageSize = CGSize(width: ECScaleHeight(rightImage.size.width), height: ECScaleHeight(rightImage.size.height))
        }
        
        if let rightImageRightSpace = rightImageRightSpace {
            self.rightImageRightSpace = rightImageRightSpace
        }
        
        if let line = line {
            self.lineRelay.accept(line)
        }
        
        if let lineColor = lineColor {
            self.lineColorRelay.accept(lineColor)
        }
        
        if let lineLayout = lineLayout {
            self.lineLayoutRelay.accept(lineLayout)
        }
        
        if let height = height {
            self.cellHeight = height
        }
        
        self.placeHolderRelay.accept(NSAttributedString(ecString: self.placeHolderString,
                                                        textColor: self.placeHolderColor,
                                                        font: self.placeHolderFont))
        switch self.type {
        case .textField:
            self.textFieldConst = (self.textFieldLeftSpace, self.textFieldRightSpace)
        case .textFieldRightImage:
            self.rightImageConst = (self.rightImageRightSpace, self.rightImageSize)
            self.textFieldConst = (self.textFieldLeftSpace, self.textFieldRightSpace + self.rightImageRightSpace - self.rightImageSize.width)
        case .leftImageTextField:
            self.leftImageConst = (self.leftImageLeftSpace, self.leftImageSize)
            self.textFieldConst = (self.leftImageLeftSpace + self.leftImageSize.width + self.textFieldLeftSpace, self.textFieldRightSpace)
        case .leftImageTextFieldRightImage:
            self.leftImageConst = (self.leftImageLeftSpace, self.leftImageSize)
            self.rightImageConst = (self.rightImageRightSpace, self.rightImageSize)
            self.textFieldConst = (self.leftImageLeftSpace + self.leftImageSize.width + self.textFieldLeftSpace, self.textFieldRightSpace + self.rightImageRightSpace - self.rightImageSize.width)
        }
        self.cellHeight = self.cellHeight ?? ECScaleHeight(60)
    }
}
