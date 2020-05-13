//
//  CountDownTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

class CountDownTableViewCell: VLBaseTableViewCell {
    
    private var itemViewModel: CountDownItemViewModel?
    var countDownLabel: UILabel?
    var timer: Timer?
    var count: Int = 0

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
        guard (itemViewModel as? CountDownItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! CountDownItemViewModel
        self.itemViewModel = itemViewModel
        
        itemViewModel.secondRelay.asDriver().drive(onNext: {[weak self] (second) in
            guard let self = self else { return }
            self.count = second
            self.timer?.fireDate = NSDate.distantPast
        }).disposed(by: disposeBag)
        
    }
    
    @objc func countDownFunction() {
        if self.count > 0 {
            self.countDownLabel?.text = "\(count)s"
            self.count -= 1
        } else {
            self.itemViewModel?.countDownEnd.accept(true)
            self.timer?.fireDate = NSDate.distantFuture
        }
    }
}

extension CountDownTableViewCell {
    // UI对象 其他操作
    override func configurateUI () {
        super.configurateUI()
        
    }
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.addSubview(self.countDownLabel!)
        
        countDownLabel?.snp.makeConstraints({ (make) in
            make.left.right.bottom.top.equalTo(self)
        })
    }
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.countDownLabel = UILabel()
        countDownLabel?.textAlignment = .center
        countDownLabel?.textColor = VLHexColor(0x00C389)
        countDownLabel?.font = VLSystemMediumFont(18)
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDownFunction), userInfo: nil, repeats: true)
        timer?.fireDate = NSDate.distantFuture
    }
}
