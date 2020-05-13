//
//  TextTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

class TextTableViewCell: VLBaseTableViewCell {
    private var showTextLabel: UILabel?
                        
    //数据填充以及处理
    override func bind(to itemViewModel: VLBaseItemViewModel?) {
        super.bind(to: itemViewModel)
        guard (itemViewModel as? TextItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! TextItemViewModel
        
        itemViewModel.attStringRelay.bind(to: self.showTextLabel!.rx.attributedText).disposed(by: disposeBag)
        itemViewModel.textAlignmentRelay.bind(to: self.showTextLabel!.rx.ecTextAlignment).disposed(by: disposeBag)
        itemViewModel.viewBGColorRelay.bind(to: self.rx.backgroundColor).disposed(by: disposeBag)
        itemViewModel.updateConstRelay.subscribe(onNext: {[weak self, weak itemViewModel] (_) in
            guard let self = self else { return }
            guard let itemViewModel = itemViewModel else { return }
            self.relayoutLabel(itemViewModel: itemViewModel)
        }).disposed(by: disposeBag)
    }
}

extension TextTableViewCell {
    private func relayoutLabel(itemViewModel: TextItemViewModel) {
        self.showTextLabel?.snp.remakeConstraints({ (make) in
            let (left, right, top, bottom) = itemViewModel.labelConst
            make.left.equalToSuperview().offset(left)
            make.right.equalToSuperview().offset(right)
            make.top.equalToSuperview().offset(top)
            make.bottom.equalToSuperview().offset(bottom)
        })
    }
}

extension TextTableViewCell {
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.addSubview(self.showTextLabel!)
        
        showTextLabel?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
                        
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.showTextLabel = UILabel()
        showTextLabel?.numberOfLines = 0
    }
}
