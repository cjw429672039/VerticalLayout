//
//  ImageTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableViewCell: VLBaseTableViewCell {

    private var centerIcon: UIImageView?

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
        guard (itemViewModel as? ImageItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! ImageItemViewModel
        itemViewModel.imageURLRelay.subscribe(onNext: {[weak self] (url) in
            guard let self = self else { return }
            if let url = url, url.absoluteString.count != 0 {
                self.centerIcon?.kf.setImage(with: url,
                                             placeholder: itemViewModel.imagePlaceholderRelay.value,
                                             options: [],
                                             progressBlock: nil,
                                             completionHandler: nil)
            } else {
                self.centerIcon?.image = itemViewModel.imagePlaceholderRelay.value
            }
        }).disposed(by: disposeBag)
        
        itemViewModel.imageSizeRelay.subscribe(onNext: {[weak self] (size) in
            guard let self = self else { return }
            self.updateCenterIconConstraints(size: size)
        }).disposed(by: disposeBag)
    }

    private func updateCenterIconConstraints(size: CGSize) {
        self.centerIcon?.snp.remakeConstraints({ (make) in
            make.centerX.centerY.equalTo(self)
//            make.width.height.equalTo(size.height)
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        })
        self.layoutIfNeeded()
    }
}

extension ImageTableViewCell {
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()

        self.addSubview(self.centerIcon!)
        self.centerIcon?.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(ECScaleWidth(120))
        })
    }
                        
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()

        self.centerIcon = UIImageView()
        self.centerIcon?.backgroundColor = .clear
        self.centerIcon?.contentMode = .scaleAspectFit
    }
}
