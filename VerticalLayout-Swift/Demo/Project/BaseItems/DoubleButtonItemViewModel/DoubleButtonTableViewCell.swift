//
//  DoubleButtonTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit
import RxSwift

class DoubleButtonTableViewCell: VLBaseTableViewCell {
    
    private var leftButton: UIButton?
    private var rightButton: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
                        
    //数据填充以及处理
    override func bind(to itemViewModel: VLBaseItemViewModel?) {
        super.bind(to: itemViewModel)
        guard (itemViewModel as? DoubleButtonItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! DoubleButtonItemViewModel
        
        itemViewModel.leftImageRelay.bind(to: self.leftButton!.rx.image()).disposed(by: disposeBag)
        itemViewModel.leftAttTextRelay.bind(to: self.leftButton!.rx.attributedTitle()).disposed(by: disposeBag)
        itemViewModel.leftButtonAlignment.bind(to: self.leftButton!.rx.ecContentHorizontalAlignment).disposed(by: disposeBag)
        itemViewModel.leftButtonBGColorRelay.bind(to: self.leftButton!.rx.backgroundColor).disposed(by: disposeBag)
        self.leftButton?.rx.tap.bind(to: itemViewModel.leftButtonAction).disposed(by: disposeBag)
        itemViewModel.rightImageRelay.bind(to: self.rightButton!.rx.image()).disposed(by: disposeBag)
        itemViewModel.rightAttTextRelay.bind(to: self.rightButton!.rx.attributedTitle()).disposed(by: disposeBag)
        itemViewModel.rightButtonAlignment.bind(to: self.rightButton!.rx.ecContentHorizontalAlignment).disposed(by: disposeBag)
        itemViewModel.rightButtonBGColorRelay.bind(to: self.rightButton!.rx.backgroundColor).disposed(by: disposeBag)
        self.rightButton?.rx.tap.bind(to: itemViewModel.rightButtonAction).disposed(by: disposeBag)
        itemViewModel.updateConstRelay.subscribe(onNext: {[weak self, weak itemViewModel] (_) in
            guard let self = self else { return }
            guard let itemViewModel = itemViewModel else { return }
            self.relayoutLabel(itemViewModel: itemViewModel)
        }).disposed(by: disposeBag)
    }
}

extension DoubleButtonTableViewCell {
    private func relayoutLabel(itemViewModel: DoubleButtonItemViewModel) {
        self.leftButton?.snp.remakeConstraints({ (make) in
            let (left, width) = itemViewModel.leftButtonLayout
            make.left.equalToSuperview().offset(left)
            make.width.equalTo(width)
            make.top.bottom.equalToSuperview()
        })
        
        self.rightButton?.snp.remakeConstraints({ (make) in
            let (left, right) = itemViewModel.rightButtonLayout
            make.left.equalTo(self.leftButton!.snp_right).offset(left)
            make.right.equalToSuperview().offset(right)
            make.top.bottom.equalToSuperview()
        })
    }
}

extension DoubleButtonTableViewCell {
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.addSubview(leftButton!)
        self.addSubview(rightButton!)
    }
                        
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.leftButton = UIButton()
        self.leftButton?.layer.cornerRadius = 8
        self.leftButton?.clipsToBounds = true
        
        self.rightButton = UIButton()
        self.rightButton?.layer.cornerRadius = 8
        self.rightButton?.clipsToBounds = true
    }
}
