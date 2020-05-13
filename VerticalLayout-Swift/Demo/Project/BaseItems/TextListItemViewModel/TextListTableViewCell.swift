//
//  TextListTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

class TextListTableViewCell: VLBaseTableViewCell {
    
    private var leftImageView: UIImageView?
    private var leftLabel: UILabel?
    private var rightLabel: UILabel?
    private var rightImageView: UIImageView?
    private var rightLabeTapGesture: UITapGestureRecognizer?
    private var rightImageTapGesture: UITapGestureRecognizer?

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
        guard (itemViewModel as? TextListItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! TextListItemViewModel
        
        itemViewModel.leftTextRelay.bind(to: self.leftLabel!.rx.attributedText).disposed(by: disposeBag)
        itemViewModel.leftTextAlignment.bind(to: self.leftLabel!.rx.ecTextAlignment).disposed(by: disposeBag)
        itemViewModel.rightTextRelay.bind(to: self.rightLabel!.rx.attributedText).disposed(by: disposeBag)
        itemViewModel.rightTextAlignment.bind(to: self.rightLabel!.rx.ecTextAlignment).disposed(by: disposeBag)
        itemViewModel.viewBGColorRelay.bind(to: self.contentView.rx.backgroundColor).disposed(by: disposeBag)
        itemViewModel.rightArrowRelay.map {!$0}.bind(to: self.rightArrowImageView!.rx.isHidden).disposed(by: disposeBag)
        itemViewModel.leftImageRelay.bind(to: self.leftImageView!.rx.ecImageURL(withPlaceholder: itemViewModel.leftPlaceImageRelay.value, options: [])).disposed(by: disposeBag)
        itemViewModel.rightImageRelay.bind(to: self.rightImageView!.rx.ecImageURL(withPlaceholder: itemViewModel.rightPlaceImageRelay.value, options: [])).disposed(by: disposeBag)
        itemViewModel.rightEnableRelay.bind(to: self.rightLabel!.rx.isUserInteractionEnabled).disposed(by: disposeBag)
        itemViewModel.rightEnableRelay.bind(to: self.rightImageView!.rx.isUserInteractionEnabled).disposed(by: disposeBag)
        //替换图的更新
        itemViewModel.leftPlaceImageRelay.subscribe(onNext: {[weak self, weak itemViewModel] (placeholderImage) in
            guard let self = self else { return }
            guard let itemViewModel = itemViewModel else { return }
            self.leftImageView?.kf.setImage(with: itemViewModel.leftImageRelay.value,
                                            placeholder: placeholderImage,
                                            options: [],
                                            progressBlock: nil,
                                            completionHandler: nil)
        }).disposed(by: disposeBag)
        //替换图的更新
        itemViewModel.rightPlaceImageRelay.subscribe(onNext: {[weak self, weak itemViewModel] (placeholderImage) in
            guard let self = self else { return }
            guard let itemViewModel = itemViewModel else { return }
            self.rightImageView?.kf.setImage(with: itemViewModel.rightImageRelay.value,
                                            placeholder: placeholderImage,
                                            options: [],
                                            progressBlock: nil,
                                            completionHandler: nil)
        }).disposed(by: disposeBag)
        //视图约束更新
        itemViewModel.updateConstRelay.subscribe(onNext: {[weak self, weak itemViewModel] (_) in
            guard let self = self else { return }
            guard let itemViewModel = itemViewModel else { return }
            self.remakCellConstraints(itemViewModel: itemViewModel)
        }).disposed(by: disposeBag)
        
        self.rightLabeTapGesture!.rx.event.bind(to: itemViewModel.rightActiongRelay).disposed(by: disposeBag)
        self.rightImageTapGesture!.rx.event.bind(to: itemViewModel.rightActiongRelay).disposed(by: disposeBag)
    }
}

extension TextListTableViewCell {
    private func remakCellConstraints(itemViewModel: TextListItemViewModel) {
        self.leftLabel?.snp.remakeConstraints({ (make) in
            make.left.equalToSuperview().offset(itemViewModel.leftLabelLeftSpace)
            make.right.equalToSuperview().offset(itemViewModel.leftLabelRightSpace)
            make.centerY.equalToSuperview()
        })
        
        self.leftImageView?.snp.remakeConstraints({ (make) in
            make.left.equalToSuperview().offset(itemViewModel.leftImageLeftSpace)
            make.size.equalTo(itemViewModel.leftImageSize)
            make.centerY.equalToSuperview()
        })
        
        self.rightLabel?.snp.remakeConstraints({ (make) in
            make.right.equalToSuperview().offset(itemViewModel.rightLabelRightSpace)
            make.width.equalTo(itemViewModel.rightLabelWidth)
            make.centerY.equalToSuperview()
        })
        
        self.rightImageView?.snp.remakeConstraints({ (make) in
            make.right.equalToSuperview().offset(itemViewModel.rightImageRightSpace)
            make.size.equalTo(itemViewModel.rightImageSize)
            make.centerY.equalToSuperview()
        })
        
        self.rightArrowImageView?.snp.remakeConstraints({ (make) in
            make.right.equalToSuperview().offset(itemViewModel.arrowImageRightSpace)
            make.centerY.equalToSuperview()
            make.size.equalTo(itemViewModel.arrowImageSize)
        })
    }
}

extension TextListTableViewCell {
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.contentView.addSubview(self.leftImageView!)
        self.contentView.addSubview(self.leftLabel!)
        self.contentView.addSubview(self.rightLabel!)
        self.contentView.addSubview(self.rightImageView!)
    }
                        
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.leftLabel = UILabel()
        leftLabel?.numberOfLines = 0
        
        self.leftImageView = UIImageView()
        leftImageView?.contentMode = .scaleAspectFit
        
        self.rightLabel = UILabel()
        leftLabel?.numberOfLines = 0
        
        self.rightImageView = UIImageView()
        rightImageView?.contentMode = .scaleAspectFit
        
        self.rightLabeTapGesture = UITapGestureRecognizer()
        rightLabel?.addGestureRecognizer(self.rightLabeTapGesture!)
        
        self.rightImageTapGesture = UITapGestureRecognizer()
        rightImageView?.addGestureRecognizer(self.rightImageTapGesture!)
    }
}
