//
//  VLBaseTableViewCell.swift
//  
//
//  Created by HarveyChen on 2019/12/4.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit
import RxSwift
//模仿OC +load()方法
protocol SwiftLoadProtocol: class {
    static func swiftLoadAwake()
}

extension UIApplication {
    private static let runOnce: Void = {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let safeTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(safeTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SwiftLoadProtocol.Type)?.swiftLoadAwake() }
        types.deallocate()
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
    
}

@objc class VLBaseTableViewCell: UITableViewCell, SwiftLoadProtocol {
    
    var lineView: UIView!
    var rightArrowImageView: UIImageView!
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //保证 cell 被重用的时候不会被多次订阅，避免错误发生。
        disposeBag = DisposeBag()
    }
    
    static func swiftLoadAwake() {
        VLGlobalUseCellSet.addCell(cellClass: self)
    }
}

// MARK: - cell的配置链
extension VLBaseTableViewCell {
    @objc func bind(to itemViewModel: VLBaseItemViewModel?) {
        guard itemViewModel != nil else {
            return
        }
        itemViewModel?.lineLayoutRelay.bind(to: self.rx.lineLayout).disposed(by: disposeBag)
        itemViewModel?.lineRelay.map {!$0}.bind(to: self.lineView!.rx.isHidden).disposed(by: disposeBag)
        itemViewModel?.lineColorRelay.bind(to: self.lineView!.rx.backgroundColor).disposed(by: disposeBag)
        itemViewModel?.rightArrowLayoutRelay.bind(to: self.rx.rightArrowLayout).disposed(by: disposeBag)
        itemViewModel?.rightArrowImageRelay.bind(to: self.rightArrowImageView!.rx.image).disposed(by: disposeBag)
        itemViewModel?.rightArrowRelay.map {!$0}.bind(to: self.rightArrowImageView!.rx.isHidden).disposed(by: disposeBag)
        self.bringSubviewToFront(lineView!)
    }
    
    @objc func configurateUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        configurateInstance()
        layoutUIInstance()
    }
    
    @objc func layoutUIInstance() {
        self.addSubview(lineView)
        self.addSubview(rightArrowImageView)
    }
    
    @objc func configurateInstance() {
        self.lineView = UIView()
        self.rightArrowImageView = UIImageView()
    }
}

extension Reactive where Base: VLBaseTableViewCell {
    /// Bindable line layout
    internal var lineLayout: Binder<VLLineViewLayout> {
        return Binder(self.base) { view, layout in
            let (leftSpace, rightSpace, bottomSpace, height) = layout
            view.lineView?.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(leftSpace)
                make.right.equalToSuperview().offset(rightSpace)
                make.bottom.equalToSuperview().offset(bottomSpace)
                make.height.equalTo(height)
            }
        }
    }
    /// Bindable rightarrow layout
    internal var rightArrowLayout: Binder<VLArrowImageLayout> {
        return Binder(self.base) { view, layout in
            let (rightSpace, imageSize) = layout
            view.rightArrowImageView?.snp.remakeConstraints { (make) in
                make.right.equalToSuperview().offset(rightSpace)
                make.size.equalTo(imageSize)
                make.centerY.equalToSuperview()
            }
        }
    }
}

class VLGlobalUseCellSet {
    static let shareInstance = VLGlobalUseCellSet()
    private init() {}
    private var cellNameList: [AnyClass] = [UITableViewCell.self]
    ///添加使用的cell
    static func addCell(cellClass: AnyClass) {
        self.shareInstance.cellNameList.append(cellClass)
    }
    ///注册使用的cell
    static func registerCell(tableView: UITableView) {
        for theClass in self.shareInstance.cellNameList {
            tableView.register(theClass, forCellReuseIdentifier: NSStringFromClass(theClass))
        }
    }
}
