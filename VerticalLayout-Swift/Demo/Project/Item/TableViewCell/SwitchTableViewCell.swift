//
//  SwitchTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

class SwitchTableViewCell: VLBaseTableViewCell {
    
    var leftLabel: UILabel?
    var rightButton: UIButton?
    var rightSwitchControl: UISwitch?
    var itemViewModel: SwitchItemViewModel?

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
        guard (itemViewModel as? SwitchItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! SwitchItemViewModel
        self.itemViewModel = itemViewModel
        
        itemViewModel.leftAttTextRelay.bind(to: self.leftLabel!.rx.attributedText).disposed(by: disposeBag)
        itemViewModel.rightImageRelay.bind(to: self.rightButton!.rx.image()).disposed(by: disposeBag)
        itemViewModel.rightAttTextRelay.bind(to: self.rightButton!.rx.attributedTitle()).disposed(by: disposeBag)
        itemViewModel.rightLottie.subscribe(onNext: {[weak self] (name) in
            guard let self = self else { return }
            if name != nil {
                self.rightSwitchControl?.isHidden = false
                self.rightButton?.isHidden = true
            } else {
                self.rightSwitchControl?.isHidden = true
                self.rightButton?.isHidden = false
            }
        }).disposed(by: disposeBag)
        itemViewModel.rightLottieValue.subscribe(onNext: {[weak self] (status) in
            guard let self = self else { return }
            self.rightSwitchControl?.isOn = status
        }).disposed(by: disposeBag)
        self.rightButton?.rx.tap.bind(to: itemViewModel.rightButtonAction).disposed(by: disposeBag)
    }
}

extension SwitchTableViewCell {
    
    @objc private func switchAction() {
        self.itemViewModel?.rightButtonAction.accept(())
    }
}

extension SwitchTableViewCell {
    // UI对象 其他操作
    override func configurateUI () {
        super.configurateUI()
        
        self.backgroundColor = VLHexColor(0xFFFFFF)
    }
                        
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.addSubview(leftLabel!)
        self.addSubview(rightButton!)
        self.addSubview(rightSwitchControl!)
        
        leftLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp_left).offset(VLScaleWidth(16))
            make.centerY.equalTo(self)
            make.width.greaterThanOrEqualTo(VLScaleWidth(140))
        })
        
        rightSwitchControl?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.snp_right).offset(-VLScaleWidth(16))
            make.centerY.equalTo(self)
        })
        
        rightButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.snp_right).offset(-VLScaleWidth(16))
            make.centerY.equalTo(self)
            make.left.equalTo(leftLabel!.snp_right).offset(VLScaleWidth(16))
        })
    }
                        
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.leftLabel = UILabel()
        
        self.rightButton = UIButton()
        
        self.rightSwitchControl = UISwitch()
        rightSwitchControl?.onTintColor = VLHexColor(0x00C389)
        self.rightSwitchControl?.addTarget(self, action: #selector(switchAction), for: .valueChanged)
    }
}
