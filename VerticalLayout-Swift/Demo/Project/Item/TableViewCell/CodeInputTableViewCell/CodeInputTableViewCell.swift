//
//  CodeInputTableViewCell.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

class CodeInputTableViewCell: VLBaseTableViewCell {
    
    var textView: UITextField?
    var coverButton: UIButton?
    var firstInputView: CodeInputView?
    var seconeInputView: CodeInputView?
    var thirdInputView: CodeInputView?
    var fourthInputView: CodeInputView?
    private var codeItemVM: CodeInputItemViewModel?

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
        guard (itemViewModel as? CodeInputItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! CodeInputItemViewModel
        self.codeItemVM = itemViewModel
        self.textView?.rx.controlEvent(.editingDidBegin).map {UIControl.Event.editingDidBegin}.bind(to: itemViewModel.textEditEventRelay).disposed(by: disposeBag)
        self.textView?.rx.controlEvent(.editingDidEnd).map {UIControl.Event.editingDidEnd}.bind(to: itemViewModel.textEditEventRelay).disposed(by: disposeBag)
        itemViewModel.becomeFirstRelay.bind(to: self.textView!.rx.ecBecomeFirstResponder()).disposed(by: disposeBag)

        itemViewModel.codeInputErrorRelay.subscribe(onNext: {[weak self] (error) in
            guard let self = self else { return }
            if error {
                self.errorAnimation()
            }
        }).disposed(by: disposeBag)

        configTextView()
    }
    
    func configTextView() {
        self.textView?
            .rx
            .controlEvent(.editingDidBegin)
            .map {() in false}
            .bind(to: self.coverButton!.rx.isHidden)
            .disposed(by: disposeBag)
        self.textView?
            .rx
            .controlEvent(.editingDidEnd)
            .map {() in true}
            .bind(to: self.coverButton!.rx.isHidden)
            .disposed(by: disposeBag)
        self.textView?.rx.controlEvent(.editingChanged).asDriver().drive(onNext: {[weak self] () in
            guard let self = self else { return }
            guard let text = self.textView?.text else { return }

            self.defaultValue()
            self.defaultAnimation()
            self.updateValue(text: text)
            
            if text.count >= 4 {
                self.textView?.text = String(text.prefix(4))
                self.codeItemVM?.codeText.accept(String(text.prefix(4)))
                self.textView?.resignFirstResponder()
                self.codeItemVM?.codeInputEndRelay.accept(())
            }
        }).disposed(by: disposeBag)
        
        self.textView?
            .rx
            .controlEvent(.editingDidEnd)
            .asDriver()
            .drive(onNext: {[weak self] (_) in
                guard let self = self else { return }
                self.defaultAnimation()
            }).disposed(by: disposeBag)
        self.textView?
            .rx
            .controlEvent(.editingDidBegin)
            .asDriver()
            .drive(onNext: {[weak self] (_) in
                guard let self = self else { return }
                self.updateValue(text: self.textView!.text ?? "", begin: true)
            }).disposed(by: disposeBag)
    }
    
    func defaultValue() {
        self.firstInputView?.configText(text: "")
        self.seconeInputView?.configText(text: "")
        self.thirdInputView?.configText(text: "")
        self.fourthInputView?.configText(text: "")
    }
    
    func defaultAnimation() {
        self.firstInputView?.animation(show: false)
        self.seconeInputView?.animation(show: false)
        self.thirdInputView?.animation(show: false)
        self.fourthInputView?.animation(show: false)
    }

    func errorAnimation() {
        self.firstInputView?.statusRealy.accept(.error)
        self.seconeInputView?.statusRealy.accept(.error)
        self.thirdInputView?.statusRealy.accept(.error)
        self.fourthInputView?.statusRealy.accept(.error)
    }

    func updateValue(text: String, begin: Bool = false) {
        for index in 0...3 {
            var string: String?
            if text.count > index {
                let index = text.index(text.startIndex, offsetBy: index)
                string = String(text[index])
            }
            switch index {
            case 0:
                self.firstInputView?.configText(text: string)
            case 1:
                self.seconeInputView?.configText(text: string)
            case 2:
                self.thirdInputView?.configText(text: string)
            case 3:
                self.fourthInputView?.configText(text: string)
            default:
                break
            }
        }
        switch text.count {
        case 0:
            self.firstInputView?.animation(show: true)
        case 1:
            self.seconeInputView?.animation(show: true)
        case 2:
            self.thirdInputView?.animation(show: true)
        case 3:
            self.fourthInputView?.animation(show: true)
        default:
            break
        }
        
        if begin && text.count == 4 {
            self.defaultAnimation()
            self.textView?.text = String(text.prefix(3))
            self.updateValue(text: String(text.prefix(3)))
        }
    }
}

extension CodeInputTableViewCell {
    // UI对象 其他操作
    override func configurateUI () {
        super.configurateUI()
    
    }
    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()
        
        self.addSubview(firstInputView!)
        self.addSubview(seconeInputView!)
        self.addSubview(thirdInputView!)
        self.addSubview(fourthInputView!)
        self.addSubview(textView!)
        self.addSubview(coverButton!)
        
        let width = (VLScreenW - 2 * VLScaleWidth(20) - 3 * VLScaleWidth(26))/4.0
        
        firstInputView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp_left).offset(VLScaleWidth(20))
            make.width.equalTo(width)
            make.top.bottom.equalTo(self)
        })
        
        seconeInputView?.snp.makeConstraints({ (make) in
            make.left.equalTo(firstInputView!.snp_right).offset(VLScaleWidth(26))
            make.width.equalTo(width)
            make.top.bottom.equalTo(self)
        })
        
        thirdInputView?.snp.makeConstraints({ (make) in
            make.left.equalTo(seconeInputView!.snp_right).offset(VLScaleWidth(26))
            make.width.equalTo(width)
            make.top.bottom.equalTo(self)
        })
        
        fourthInputView?.snp.makeConstraints({ (make) in
            make.left.equalTo(thirdInputView!.snp_right).offset(VLScaleWidth(26))
            make.right.equalTo(self.snp_right).offset(-VLScaleWidth(20))
            make.top.bottom.equalTo(self)
        })
        
        textView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self)
        })
        
        coverButton?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self)
        })
    }
    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()
        
        self.firstInputView = CodeInputView()
        self.seconeInputView = CodeInputView()
        self.thirdInputView = CodeInputView()
        self.fourthInputView = CodeInputView()
        
        self.textView = UITextField()
        textView?.textColor = .clear
        textView?.tintColor = .clear
        textView?.keyboardType = .numberPad
        textView?.backgroundColor = .clear
        
        self.coverButton = UIButton()
        coverButton?.isHidden = true
    }
}
