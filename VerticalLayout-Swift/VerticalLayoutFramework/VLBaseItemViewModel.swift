//
//  VLBaseItemViewModel.swift
//
//
//  Created by HarveyChen on 2019/12/25.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

typealias VLLineViewLayout = (left: CGFloat, right: CGFloat, bottom: CGFloat, height: CGFloat)
typealias VLArrowImageLayout = (rightSpace: CGFloat, imageSize: CGSize)
///这个类用于对cell视图的UI配置，UI逻辑处理存放的地方
class VLBaseItemViewModel: NSObject {
    //Rx资源回收包
    let disposeBag = DisposeBag()
    ///cell视图底部线显示
    let lineRelay = BehaviorRelay<Bool>(value: false)
    ///cell右侧箭头显示
    let rightArrowRelay = BehaviorRelay<Bool>(value: false)
    ///cell点击事件响应类型
    let selectTypeRelay = BehaviorRelay<SelectType?>(value: nil)
    ///右侧箭头图片
    let rightArrowImageRelay = BehaviorRelay<UIImage>(value: UIImage())
    ///cell视图底部线布局
    let lineLayoutRelay = BehaviorRelay<VLLineViewLayout>(value: (VLScaleWidth(16), -VLScaleWidth(16), 0, VLScaleHeight(0.5)))
    ///线的颜色
    let lineColorRelay = BehaviorRelay<UIColor>(value: UIColor(red: 0xdd/255.0, green: 0xdd/255.0, blue: 0xdd/255.0, alpha: 1))
    ///cell右侧箭头布局
    let rightArrowLayoutRelay = BehaviorRelay<VLArrowImageLayout>(value: (-VLScaleWidth(16), CGSize(width: VLScaleWidth(12), height: VLScaleWidth(12))))
    ///item对应的cell，严格控制一个item只能对应一种cell
    var itemSupportClassName: AnyClass!
    ///cell视图高度
    var cellHeight: CGFloat?
    
    init(itemSupportClassName: AnyClass,
         line: Bool? = nil,
         lineLayout: VLLineViewLayout? = nil,
         rightArrow: Bool? = nil,
         rightArrowImage: UIImage? = nil,
         rightArrowLayout: VLArrowImageLayout? = nil,
         cellHeight: CGFloat? = nil,
         selectType: SelectType? = nil) {
        super.init()
        self.itemSupportClassName = itemSupportClassName
        self.statusUpdate(line: line,
                          lineLayout: lineLayout,
                          rightArrow: rightArrow,
                          rightArrowImage: rightArrowImage,
                          rightArrowLayout: rightArrowLayout,
                          cellHeight: cellHeight,
                          selectType: selectType)
    }
    
    func statusUpdate(line: Bool? = nil,
                      lineLayout: VLLineViewLayout? = nil,
                      rightArrow: Bool? = nil,
                      rightArrowImage: UIImage? = nil,
                      rightArrowLayout: VLArrowImageLayout? = nil,
                      cellHeight: CGFloat? = nil,
                      selectType: SelectType? = nil) {
        if let line = line {
            self.lineRelay.accept(line)
        }
        
        if let lineLayout = lineLayout {
            self.lineLayoutRelay.accept(lineLayout)
        }
        
        if let rightArrow = rightArrow {
            self.rightArrowRelay.accept(rightArrow)
        }
        
        if let rightArrowImage = rightArrowImage {
            self.rightArrowImageRelay.accept(rightArrowImage)
        }
        
        if let rightArrowLayout = rightArrowLayout {
            self.rightArrowLayoutRelay.accept(rightArrowLayout)
        }
        
        if let cellHeight = cellHeight {
            self.cellHeight = cellHeight
        }
        
        if let selectType = selectType {
            self.selectTypeRelay.accept(selectType)
        }
    }
}
