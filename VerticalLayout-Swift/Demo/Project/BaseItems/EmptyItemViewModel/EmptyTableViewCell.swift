//
//  EmptyTableViewCell.swift
//  Assureapt
//
//  Created by HarveyChen on 2020/4/14.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class EmptyTableViewCell: VLBaseTableViewCell {

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
        
		guard (itemViewModel as? EmptyItemViewModel) != nil else {
            return
        }
        let itemViewModel: EmptyItemViewModel = itemViewModel as! EmptyItemViewModel
        itemViewModel.viewBGColorRelay.bind(to: self.rx.backgroundColor).disposed(by: disposeBag)
    }
}
