//
//  ButtonItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit

class ButtonItemViewModel: VLBaseItemViewModel {
    let attStringRelay = BehaviorRelay<NSAttributedString?>(value: nil)
    let alignmentRelay = BehaviorRelay<UIControl.ContentHorizontalAlignment>(value: .center)
    let buttonBgColorRelay = BehaviorRelay<UIColor>(value: .clear)
    let cellBgColorRelay = BehaviorRelay<UIColor>(value: .clear)
    let buttonEnableRelay = BehaviorRelay<Bool>(value: true)
    let action = PublishSubject<Void>()
    let loadingRealy = BehaviorRelay<Bool>(value: false)
    let updateConstRelay = BehaviorRelay<Void>(value: ())
    var buttonConst: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
    
    private var buttonLeftSpace: CGFloat = ECScaleWidth(0)
    private var buttonRightSpace: CGFloat = ECScaleWidth(0)
    private var buttonTopSpace: CGFloat = ECScaleWidth(0)
    private var buttonBottomSpace: CGFloat = ECScaleWidth(0)
    private var enableTextColor: UIColor?
    private var disableTextColor: UIColor?
    private var enableTextFont: UIFont?
    private var disableTextFont: UIFont?
    private var enableBtnBgColor: UIColor?
    private var disableBtnBgColor: UIColor?
    
    private var text: String?
    //文字下划线
    private var textLine: Bool = false
    //cell可用宽度
    private var cellWidth: CGFloat = ECScreenW
    //button固定高度
    private var buttonHeight: CGFloat?
    //cell固定高度
    private var cellUseHeight: CGFloat?
    
    init(text: String?,
         enableTextColor: UIColor? = nil,
         disableTextColor: UIColor? = nil,
         enableTextFont: UIFont? = nil,
         disableTextFont: UIFont? = nil,
         enableBtnBgColor: UIColor? = nil,
         disableBtnBgColor: UIColor? = nil,
         cellBgColor: UIColor? = nil,
         alignment: UIControl.ContentHorizontalAlignment? = nil,
         textLine: Bool? = nil,
         loading: Bool? = nil,
         leftSpace: CGFloat? = nil,
         rightSpace: CGFloat? = nil,
         topSpace: CGFloat? = nil,
         bottomSpace: CGFloat? = nil,
         buttonHeight: CGFloat? = nil,
         cellWidth: CGFloat? = nil,
         cellHeight: CGFloat? = nil,
         enable: Bool = true,
         line: Bool = false,
         selectType: SelectType? = nil) {
        super.init(itemSupportClassName: ButtonTableViewCell.self, line: line, selectType: selectType)
        
        self.update(text: text,
                    enableTextColor: enableTextColor,
                    disableTextColor: disableTextColor,
                    enableTextFont: enableTextFont,
                    disableTextFont: disableTextFont,
                    enableBtnBgColor: enableBtnBgColor,
                    disableBtnBgColor: disableBtnBgColor,
                    cellBgColor: cellBgColor,
                    alignment: alignment,
                    textLine: textLine,
                    loading: loading,
                    leftSpace: leftSpace,
                    rightSpace: rightSpace,
                    topSpace: topSpace,
                    bottomSpace: bottomSpace,
                    buttonHeight: buttonHeight,
                    cellWidth: cellWidth,
                    cellHeight: cellHeight,
                    enable: enable)
        self.bind()
    }
}

extension ButtonItemViewModel {
    func update(text: String? = nil,
                enableTextColor: UIColor? = nil,
                disableTextColor: UIColor? = nil,
                enableTextFont: UIFont? = nil,
                disableTextFont: UIFont? = nil,
                enableBtnBgColor: UIColor? = nil,
                disableBtnBgColor: UIColor? = nil,
                cellBgColor: UIColor? = nil,
                alignment: UIControl.ContentHorizontalAlignment? = nil,
                textLine: Bool? = nil,
                loading: Bool? = nil,
                leftSpace: CGFloat? = nil,
                rightSpace: CGFloat? = nil,
                topSpace: CGFloat? = nil,
                bottomSpace: CGFloat? = nil,
                buttonHeight: CGFloat? = nil,
                cellWidth: CGFloat? = nil,
                cellHeight: CGFloat? = nil,
                enable: Bool? = nil) {
        
        if let text = text {
            self.text = text
        }
        
        if let enableTextColor = enableTextColor {
            self.enableTextColor = enableTextColor
        }
        
        if let disableTextColor = disableTextColor {
            self.disableTextColor = disableTextColor
        }
        
        if let enableTextFont = enableTextFont {
            self.enableTextFont = enableTextFont
        }
        
        if let disableTextFont = disableTextFont {
            self.disableTextFont = disableTextFont
        }
        
        if let enableBtnBgColor = enableBtnBgColor {
            self.enableBtnBgColor = enableBtnBgColor
        }
        
        if let disableBtnBgColor = disableBtnBgColor {
            self.disableBtnBgColor = disableBtnBgColor
        }
        
        if let cellBgColor = cellBgColor {
            self.cellBgColorRelay.accept(cellBgColor)
        }
        
        if let alignment = alignment {
            self.alignmentRelay.accept(alignment)
        }
        
        if let textLine = textLine {
            self.textLine = textLine
        }
        
        if let loading = loading {
            self.loadingRealy.accept(loading)
        }
        
        if let leftSpace = leftSpace {
            self.buttonLeftSpace = leftSpace
        }
        
        if let rightSpace = rightSpace {
            self.buttonRightSpace = rightSpace
        }
        
        if let topSpace = topSpace {
            self.buttonTopSpace = topSpace
        }
        
        if let bottomSpace = bottomSpace {
            self.buttonBottomSpace = bottomSpace
        }
        
        if let cellWidth = cellWidth {
            self.cellWidth = cellWidth
        }
        
        if let buttonHeight = buttonHeight {
            self.buttonHeight = buttonHeight
        }
        
        if let cellHeight = cellHeight {
            self.cellHeight = cellHeight
        }
        
        if let enable = enable {
            self.buttonEnableRelay.accept(enable)
        }
        self.update(enableSetting: self.buttonEnableRelay.value)
        self.buttonConst = (self.buttonLeftSpace, self.buttonRightSpace, self.buttonTopSpace, self.buttonBottomSpace)
        self.updateConstRelay.accept(())
        
        if let cellHeight = self.cellUseHeight {
            self.cellHeight = cellHeight
        } else if let buttonHeight = self.buttonHeight {
            self.cellHeight = buttonHeight + self.buttonTopSpace - self.buttonBottomSpace
        } else {
            self.cellHeight = self.attStringRelay.value?.ecGetSize(width: self.cellWidth - self.buttonLeftSpace + self.buttonRightSpace).height
        }
    }
    
    private func update(enableSetting enable: Bool) {
        var textColor: UIColor?
        var textFont: UIFont?
        var buttonBgColor: UIColor?
        
        if enable {
            if let enableTextColor = self.enableTextColor {
                textColor = enableTextColor
            } else if let disableTextColor = self.disableTextColor {
                textColor = disableTextColor
            }
            
            if let enableTextFont = self.enableTextFont {
                textFont = enableTextFont
            } else if let disableTextFont = self.disableTextFont {
                textFont = disableTextFont
            }
            
            if let enableBtnBgColor = self.enableBtnBgColor {
                buttonBgColor = enableBtnBgColor
            } else if let disableBtnBgColor = self.disableBtnBgColor {
                buttonBgColor = disableBtnBgColor
            }
        } else {
            if let disableTextColor = self.disableTextColor {
                textColor = disableTextColor
            } else if let enableTextColor = self.enableTextColor {
                textColor = enableTextColor
            }
            
            if let disableTextFont = self.disableTextFont {
                textFont = disableTextFont
            } else if let enableTextFont = self.enableTextFont {
                textFont = enableTextFont
            }
            
            if let disableBtnBgColor = self.disableBtnBgColor {
                buttonBgColor = disableBtnBgColor
            } else if let enableBtnBgColor = self.enableBtnBgColor {
                buttonBgColor = enableBtnBgColor
            }
        }
        self.buttonBgColorRelay.accept(buttonBgColor ?? UIColor.clear)
        
        if self.loadingRealy.value == true {
            return
        }
        
        self.attStringRelay.accept(self.attString(text: self.text,
                                                  textColor: textColor,
                                                  textFont: textFont,
                                                  line: self.textLine))
    }
    
    private func bind() {
        self.buttonEnableRelay.subscribe(onNext: {[weak self] (enable) in
            guard let self = self else { return }
            self.update(enableSetting: enable)
        }).disposed(by: disposeBag)
    }
    
    private func attString(text: String?, textColor: UIColor?, textFont: UIFont?, line: Bool = false) -> NSAttributedString {
        
        return NSAttributedString(string: text ?? "",
                                  textColor: textColor ?? ECHexColor(0x999999),
                                  font: textFont ?? ECSystemRegularFont(15),
                                  line: line)
    }
}
