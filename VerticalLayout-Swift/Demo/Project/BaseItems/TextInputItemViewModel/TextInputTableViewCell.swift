//
//  TextInputTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TextInputTableViewCell: VLBaseTableViewCell {

    var leftImageView: UIImageView?
    var textField: UITextField?
    var rightButton: UIButton?
    
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
        guard (itemViewModel as? TextInputItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! TextInputItemViewModel
        itemViewModel.leftImageRelay.bind(to: self.leftImageView!.rx.image).disposed(by: disposeBag)
        itemViewModel.textRelay.bind(to: self.textField!.rx.text).disposed(by: disposeBag)
        self.textField!.rx.text.bind(to: itemViewModel.textRelay).disposed(by: disposeBag)
        itemViewModel.placeHolderRelay.bind(to: self.textField!.rx.ecAttributedPlaceholder).disposed(by: disposeBag)
        itemViewModel.textColorRelay.bind(to: self.textField!.rx.ecTextColor).disposed(by: disposeBag)
        itemViewModel.textFontRelay.bind(to: self.textField!.rx.ecTextFont).disposed(by: disposeBag)
        itemViewModel.isPasswordRelay.bind(to: self.textField!.rx.ecSecureTextEntry).disposed(by: disposeBag)
        itemViewModel.keyBoardTypeRelay.bind(to: self.textField!.rx.ecKeyboardType).disposed(by: disposeBag)
        itemViewModel.textFieldTinColorRelay.bind(to: self.textField!.rx.ecTintColor).disposed(by: disposeBag)
        self.textField!.rx.controlEvent(.editingDidEnd).map {UIControl.Event.editingDidEnd}.bind(to: itemViewModel.textFieldEventRelay).disposed(by: disposeBag)
        self.textField!.rx.controlEvent(.editingChanged).map {UIControl.Event.editingChanged}.bind(to: itemViewModel.textFieldEventRelay).disposed(by: disposeBag)
        self.textField!.rx.controlEvent(.editingDidBegin).map {UIControl.Event.editingDidBegin}.bind(to: itemViewModel.textFieldEventRelay).disposed(by: disposeBag)
        itemViewModel.becomeFirstRelay.bind(to: self.textField!.rx.ecBecomeFirstResponder()).disposed(by: disposeBag)
        itemViewModel.rightImageRelay.bind(to: self.rightButton!.rx.image()).disposed(by: disposeBag)
        self.rightButton!.rx.tap.bind(to: itemViewModel.rightAction).disposed(by: disposeBag)
        
        itemViewModel.updateConstRelay.subscribe(onNext: {[weak self, weak itemViewModel] (_) in
            guard let self = self else { return }
            guard let itemViewModel = itemViewModel else { return }
            self.remakCellConstraints(itemViewModel: itemViewModel)
        }).disposed(by: disposeBag)
    }
}

extension TextInputTableViewCell {
    private func remakCellConstraints(itemViewModel: TextInputItemViewModel) {
        
        let (leftImageLeftSpace, leftImageSize) = itemViewModel.leftImageConst
        self.leftImageView?.snp.remakeConstraints({ (make) in
            make.left.equalToSuperview().offset(leftImageLeftSpace)
            make.size.equalTo(leftImageSize)
            make.centerY.equalTo(self.textField!)
        })
        
        let (textFieldLeftSpace, textFieldRightSpace) = itemViewModel.textFieldConst
        self.textField?.snp.remakeConstraints({ (make) in
            make.left.equalToSuperview().offset(textFieldLeftSpace)
            make.right.equalToSuperview().offset(textFieldRightSpace)
            make.top.bottom.equalToSuperview()
        })
        
        let (rightImageRightSpace, rightImageSize) = itemViewModel.rightImageConst
        self.rightButton?.snp.remakeConstraints({ (make) in
            make.right.equalToSuperview().offset(rightImageRightSpace)
            make.size.equalTo(rightImageSize)
            make.centerY.equalTo(self.textField!)
        })
    }
}

extension TextInputTableViewCell {
    // UI对象 其他操作
    override func configurateUI () {
        super.configurateUI()
        
    }
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.contentView.addSubview(self.leftImageView!)
        self.contentView.addSubview(self.textField!)
        self.contentView.addSubview(self.rightButton!)
    }
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.leftImageView = UIImageView()
        leftImageView?.contentMode = .scaleAspectFit
        
        self.textField = UITextField()
        
        self.rightButton = UIButton()
        rightButton?.imageView?.contentMode = .scaleAspectFit
        rightButton?.contentMode = .scaleAspectFit
    }
}
