//
//  VLBaseCollectionViewCell.swift
//  
//
//  Created by Jerry on 2020/3/16.
//  Copyright © 2020 . All rights reserved.
//

import UIKit
import RxSwift

class VLBaseCollectionViewCell: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //保证 cell 被重用的时候不会被多次订阅，避免错误发生。
        disposeBag = DisposeBag()
    }
}

// MARK: - cell的配置链
extension VLBaseCollectionViewCell {
    @objc func bind(to _: VLBaseItemViewModel?) {
        
    }
    
    @objc func configurateUI() {
        self.backgroundColor = .clear
        
        configurateInstance()
        layoutUIInstance()
    }
    
    @objc func layoutUIInstance() {
        
    }
    
    @objc func configurateInstance() {
        
    }
}
