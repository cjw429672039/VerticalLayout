//
//  TextItemViewModel.swift
//  
//
//  Created 
//  Copyright ©  All rights reserved.
//

import UIKit

class TextItemViewModel: VLBaseItemViewModel {
    let attStringRelay = BehaviorRelay<NSAttributedString?>(value: nil)
    let textAlignmentRelay = BehaviorRelay<NSTextAlignment>(value: .left)
    let viewBGColorRelay = BehaviorRelay<UIColor>(value: .clear)
    let updateConstRelay = BehaviorRelay<Void>(value: ())
    var labelConst: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
    
    private var leftSpace: CGFloat = 0
    private var rightSpace: CGFloat = 0
    private var topSpace: CGFloat = 0
    private var bottomSpace: CGFloat = 0
    private var textColor: UIColor?
    private var textFont: UIFont?
    private var text: String?
    private var textLine: Bool = false
    //cell可用宽度
    private var cellWidth: CGFloat = ECScreenW
    //cell固定高度
    private var cellUseHeight: CGFloat?
    
    init(text: String?,
         textLine: Bool? = nil,
         textColor: UIColor? = nil,
         textFont: UIFont? = nil,
         textAlignment: NSTextAlignment? = nil,
         viewBGColor: UIColor? = nil,
         leftSpace: CGFloat? = nil,
         rightSpace: CGFloat? = nil,
         topSpace: CGFloat? = nil,
         bottomSpace: CGFloat? = nil,
         cellWidth: CGFloat? = nil,
         cellHeight: CGFloat? = nil,
         line: Bool = false,
         selectType: SelectType? = nil) {
        super.init(itemSupportClassName: TextTableViewCell.self, line: line, selectType: selectType)
        
        self.update(text: text,
                    textLine: textLine,
                    textColor: textColor,
                    textFont: textFont,
                    textAlignment: textAlignment,
                    viewBGColor: viewBGColor,
                    leftSpace: leftSpace,
                    rightSpace: rightSpace,
                    topSpace: topSpace,
                    bottomSpace: bottomSpace,
                    cellWidth: cellWidth,
                    cellHeight: cellHeight,
                    line: line,
                    selectType: selectType)
    }
}

extension TextItemViewModel {
    func update(text: String? = nil,
                textLine: Bool? = nil,
                textColor: UIColor? = nil,
                textFont: UIFont? = nil,
                textAlignment: NSTextAlignment? = nil,
                viewBGColor: UIColor? = nil,
                leftSpace: CGFloat? = nil,
                rightSpace: CGFloat? = nil,
                topSpace: CGFloat? = nil,
                bottomSpace: CGFloat? = nil,
                cellWidth: CGFloat? = nil,
                cellHeight: CGFloat? = nil,
                line: Bool? = nil,
                selectType: SelectType? = nil) {
        
        if let text = text {
            self.text = text
        }
        
        if let textLine = textLine {
            self.textLine = textLine
        }
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let textFont = textFont {
            self.textFont = textFont
        }
        
        if let textAlignment = textAlignment {
            self.textAlignmentRelay.accept(textAlignment)
        }
        
        if let leftSpace = leftSpace {
            self.leftSpace = leftSpace
        }
        
        if let rightSpace = rightSpace {
            self.rightSpace = rightSpace
        }
        
        if let topSpace = topSpace {
            self.topSpace = topSpace
        }
        
        if let bottomSpace = bottomSpace {
            self.bottomSpace = bottomSpace
        }
        
        if let cellWidth = cellWidth {
            self.cellWidth = cellWidth
        }
        
        if let cellHeight = cellHeight {
            self.cellUseHeight = cellHeight
        }
        
        if let viewBGColor = viewBGColor {
            self.viewBGColorRelay.accept(viewBGColor)
        }
        
        if let line = line {
            self.lineRelay.accept(line)
        }
        
        if let selectType = selectType {
            self.selectTypeRelay.accept(selectType)
        }
        
        self.attStringRelay.accept(self.attString(text: self.text, textColor: self.textColor, textFont: self.textFont, textLine: self.textLine))
        self.labelConst = (self.leftSpace, self.rightSpace, self.topSpace, self.bottomSpace)
        self.updateConstRelay.accept(())
        self.cellHeight = self.cellUseHeight ?? ((self.attStringRelay.value?.ecGetSize(width: self.cellWidth - self.leftSpace + self.rightSpace)
            .height ?? 0) + self.topSpace - self.bottomSpace)
    }
}

extension TextItemViewModel {
    private func attString(text: String?, textColor: UIColor?, textFont: UIFont?, textLine: Bool) -> NSAttributedString {
        return NSAttributedString(ecString: text ?? "",
                                  textColor: textColor ?? ECHexColor(0x999999),
                                  font: textFont ?? ECSystemRegularFont(15),
                                  line: textLine)
    }
}
