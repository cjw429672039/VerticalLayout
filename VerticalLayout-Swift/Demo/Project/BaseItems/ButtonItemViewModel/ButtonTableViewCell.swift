//
//  ButtonTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

class ButtonTableViewCell: VLBaseTableViewCell {
    
    private var actionButton: UIButton?
    private var loadingView: UIImageView?
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
        guard (itemViewModel as? ButtonItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! ButtonItemViewModel

        itemViewModel.attStringRelay.bind(to: self.actionButton!.rx.attributedTitle()).disposed(by: disposeBag)
        itemViewModel.buttonBgColorRelay.bind(to: self.actionButton!.rx.backgroundColor).disposed(by: disposeBag)
        itemViewModel.cellBgColorRelay.bind(to: self.rx.backgroundColor).disposed(by: disposeBag)
        itemViewModel.buttonEnableRelay.bind(to: self.actionButton!.rx.isEnabled).disposed(by: disposeBag)
        itemViewModel.alignmentRelay.bind(to: self.actionButton!.rx.ecContentHorizontalAlignment).disposed(by: disposeBag)
        
        itemViewModel.loadingRealy.subscribe(onNext: {[weak self, weak itemViewModel] (animation) in
            guard let self = self else { return }
            guard let itemViewModel = itemViewModel else { return }
            self.updateloadingViewAnimation(isAnimation: animation, itemViewModel: itemViewModel)
        }).disposed(by: disposeBag)
        
        itemViewModel.updateConstRelay.subscribe(onNext: {[weak self, weak itemViewModel] (_) in
            guard let self = self else { return }
            guard let itemViewModel = itemViewModel else { return }
            self.relayoutLabel(itemViewModel: itemViewModel)
        }).disposed(by: disposeBag)
        
        self.actionButton!.rx.tap.bind(to: itemViewModel.action).disposed(by: disposeBag)
    }
}

extension ButtonTableViewCell {
    private func relayoutLabel(itemViewModel: ButtonItemViewModel) {
        self.actionButton?.snp.remakeConstraints({ (make) in
            let (left, right, top, bottom) = itemViewModel.buttonConst
            make.left.equalToSuperview().offset(left)
            make.right.equalToSuperview().offset(right)
            make.top.equalToSuperview().offset(top)
            make.bottom.equalToSuperview().offset(bottom)
        })
    }
    
    private func updateloadingViewAnimation(isAnimation: Bool, itemViewModel: ButtonItemViewModel) {
        self.loadingView?.isHidden = !isAnimation
        if isAnimation {
            self.actionButton?.setAttributedTitle(nil, for: .normal)
            let loadingAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            loadingAnimation.fromValue = 0.0
            loadingAnimation.toValue = 2 * Double.pi
            loadingAnimation.duration = 1.0
            loadingAnimation.repeatCount = MAXFLOAT
            self.loadingView?.layer.add(loadingAnimation, forKey: nil)

        } else {
            self.loadingView?.layer.removeAllAnimations()
            self.actionButton?.setAttributedTitle(itemViewModel.attStringRelay.value, for: .normal)
        }
    }
}

extension ButtonTableViewCell {
    // UI对象 其他操作
    override func configurateUI () {
        super.configurateUI()
        
    }
                        
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.addSubview(self.actionButton!)
        self.addSubview(self.loadingView!)
        
        loadingView?.snp.makeConstraints({ (make) in
            make.center.equalTo(self.actionButton!)
        })
    }
                        
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.actionButton = UIButton()
        actionButton?.layer.cornerRadius = ECScaleHeight(8)
        actionButton?.clipsToBounds = true
        
        self.loadingView = UIImageView()
        self.loadingView?.image = UIImage(named: "loginLoading")
        self.loadingView?.contentMode = .scaleAspectFit
        self.loadingView?.isHidden = true
    }
}
