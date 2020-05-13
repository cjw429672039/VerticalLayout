//
//  ImageTableViewCell.swift
//
//
//  Created
//  Copyright © . All rights reserved.
//

import UIKit

class AttributedTextViewTableViewCell: VLBaseTableViewCell {

    private var textView: UITextView?
    private var linkActionRelay = BehaviorRelay<URL?>(value: nil)

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
        guard (itemViewModel as? AttributedTextViewItemViewModel) != nil else {
            return
        }
        let itemViewModel = itemViewModel as! AttributedTextViewItemViewModel
        self.linkActionRelay.bind(to: itemViewModel.linkActionRelay).disposed(by: disposeBag)
        updateCellConstraints(itemViewModel)
    }

    private func updateCellConstraints(_ itemViewModel: AttributedTextViewItemViewModel) {
        textView?.snp.remakeConstraints({ (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(self.snp_left).offset(itemViewModel.leftOffsetRelay.value!)
            make.right.equalTo(self.snp.right).offset(-itemViewModel.rightOffsetRelay.value!)
        })
        textView?.textAlignment = itemViewModel.textAlignmentRelay.value!

        let allString = itemViewModel.attrTextRelay.value!
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string: allString)
        attrString.addAttributes([NSAttributedString.Key.foregroundColor: VLHexColor(0x999999)], range: NSMakeRange(0, allString.count))
        let linkTextItems = itemViewModel.linkTextItemsRelay.value
        for (index, linkItem) in linkTextItems.enumerated() {
            let range: Range = allString.range(of: linkItem)!
            let location = allString.distance(from: allString.startIndex, to: range.lowerBound)
            attrString.addAttribute(NSAttributedString.Key.link, value: itemViewModel.linkURLItemsRelay.value[index] as Any, range: NSRange(location: location, length: linkItem.count))
        }
        textView?.linkTextAttributes = [NSAttributedString.Key.foregroundColor: itemViewModel.linkTextColorRelay.value,
                                        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        textView?.attributedText = attrString
    }
}

extension AttributedTextViewTableViewCell {
    // UI对象 其他操作
    override func configurateUI () {
        super.configurateUI()

    }

    // UI对象 addSubview和UI布局
    override func layoutUIInstance() {
        super.layoutUIInstance()

        self.addSubview(self.textView!)
        self.textView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.snp_left).offset(VLScaleWidth(20))
            make.right.equalTo(self.snp_right).offset(-VLScaleWidth(20))
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }

    // UI对象 实例化
    override func configurateInstance() {
        super.configurateInstance()

        self.textView = UITextView()
        self.textView?.delegate = self
        self.textView?.isScrollEnabled = false
        self.textView?.isEditable = false
        self.textView?.isSelectable = true
        self.textView?.font = VLSystemRegularFont(12)
        self.textView?.dataDetectorTypes = .link
    }
}

extension AttributedTextViewTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return false
    }

    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.linkActionRelay.accept(URL)
        return false
    }
}
