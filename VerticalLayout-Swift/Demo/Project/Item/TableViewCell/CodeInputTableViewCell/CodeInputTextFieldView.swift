//
//  CodeInputTextFieldView.swift
//  Assureapt
//
//  Created by HarveyChen on 2020/1/8.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

enum LineStatus {
    case enable
    case unenable
    case error
}

class CodeInputView: UIView {

    private var codeLabel: UILabel?
    private var lineView: UIView?
    private var centerLineView: UIView?
    private var timer: Timer?
    let statusRealy = BehaviorRelay<LineStatus>(value: .unenable)
    //Rx资源回收包
    var disposeBag = DisposeBag()
    
    init() {
        super.init(frame: CGRect.zero)
        self.configurateUI()
        statusRealy.asDriver().drive(onNext: {[weak self] (status) in
            guard let self = self else { return }
            switch status {
            case .enable:
                self.lineView?.backgroundColor = VLHexColor(0x00C389)
            case .unenable:
                self.lineView?.backgroundColor = VLHexColor(0xDDDDDD)
            case .error:
                self.lineView?.backgroundColor = VLHexColor(0xFA584D)
            }
        }).disposed(by: disposeBag)
    }
    
    func configText(text: String?) {
        self.codeLabel?.text = text
    }
    
    func animation(show: Bool) {
        self.statusRealy.accept(show ? .enable : .unenable)
        if show {
            self.timer?.fireDate = NSDate.distantPast
        } else {
            self.timer?.fireDate = NSDate.distantFuture
            self.centerLineView?.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CodeInputView {
    @objc func configurateUI() {
        self.backgroundColor = .clear
        
        configurateInstance()
        layoutUIInstance()
    }
    
    @objc func layoutUIInstance() {
        self.addSubview(lineView!)
        self.addSubview(codeLabel!)
        self.addSubview(centerLineView!)
        
        lineView?.snp.makeConstraints({ (make) in
            make.height.equalTo(VLScaleHeight(1))
            make.left.equalTo(self.snp_left).offset(VLScaleWidth(0))
            make.right.equalTo(self.snp_right).offset(-VLScaleWidth(0))
            make.bottom.equalTo(self.snp_bottom)
        })
        
        codeLabel?.snp.makeConstraints({ (make) in
            make.left.right.centerY.equalTo(self)
            make.height.equalTo(VLScaleHeight(20))
        })
        
        centerLineView?.snp.makeConstraints({ (make) in
            make.width.equalTo(VLScaleWidth(2))
            make.height.equalTo(VLScaleHeight(20))
            make.centerY.centerX.equalTo(self)
        })
    }
    
    @objc func configurateInstance() {
        self.lineView = UIView()
        lineView?.backgroundColor = VLHexColor(0xDDDDDD)
        
        self.centerLineView = UIView()
        centerLineView?.backgroundColor = VLHexColor(0x00C389)
        centerLineView?.isHidden = true
        
        self.codeLabel = UILabel()
        codeLabel?.textColor = VLHexColor(0x333333)
        codeLabel?.font = VLSystemMediumFont(25)
        codeLabel?.textAlignment = .center
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(lineShow), userInfo: nil, repeats: true)
        self.timer?.fireDate = NSDate.distantFuture
    }
    
    @objc private func lineShow() {
        self.centerLineView?.isHidden = !self.centerLineView!.isHidden
    }
}
