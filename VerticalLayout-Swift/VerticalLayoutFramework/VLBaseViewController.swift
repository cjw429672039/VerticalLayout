//
//  VLBaseViewController.swift
//  
//
//  Created by HarveyChen on 2019/12/3.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class VLBaseViewController: UIViewController {
    ///Rx资源回收包
    let disposeBag = DisposeBag()
    ///VC的ViewModel
    var viewModel: VLBaseViewModel?
    ///视图容器
    var tableView: UITableView?
    ///背景图片
    var bgImageView: UIImageView?
    ///自定义导航栏
    var navigationBar: VLNavigationBarView?
    ///上拉和下拉刷新
    let refresh = PublishRelay<RefreshType>()
    ///tableViewCell点击
    let tableViewClickAction = PublishRelay<SelectType?>()
    ///vc生命周期
    let vcLifeRelay = PublishRelay<ViewControllerLifeType>()
    ///导航栏左右按钮点击
    let barClickRelay = PublishRelay<LeftRightBarClickType>()
    ///弹窗点击反馈
    let alerViewAction = PublishRelay<AlertViewActionProtocol>()
    ///ViewModel接收VC值传递
    let viewModelReceptionAction = PublishRelay<ViewModelReceptionActionProtocol>()
    
    // MARK: - viewController的周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurateUI()
        self.signalBindViewModel()
        self.vcLifeRelay.accept(.viewDidLoad)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.vcLifeRelay.accept(.viewWillDisappear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.vcLifeRelay.accept(.viewDidDisappear)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.vcLifeRelay.accept(.viewDidAppear)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.vcLifeRelay.accept(.viewWillAppear)
        self.navigationController?.navigationBar.isHidden = true
        self.view.bringSubviewToFront(self.navigationBar!)
    }
    
    func handle(controllerResponse action: ViewControllerActionProtocol) {
        
    }
    
    func handle(alertClick action: AlertViewActionProtocol) {
        
    }
    
    deinit {
        print("")
        print("")
        print("页面释放了\(self.classForCoder)")
        print("")
        print("")
        VLViewControllerConfig.viewControllerDeinit(tableView: self.tableView)
    }
}
extension VLBaseViewController {
    func addDriver(tableViewAction: Driver<TableViewAction>? = nil,
                   progressHUDAction: Driver<ProgressHUDType>? = nil,
                   alertViewAction: Driver<AlertViewAction>? = nil,
                   viewControllerAction: Driver<ViewControllerActionProtocol?>? = nil) {
        if let tableViewAction = tableViewAction {
            tableViewAction.drive(onNext: {[weak self] (action) in
                guard let self = self else { return }
                switch action {
                case .reload:
                    VLViewControllerConfig.endRefreshSetting(tableView: self.tableView)
                    self.tableView?.reloadData()
                case .reloadHeight:
                    self.tableView?.beginUpdates()
                    self.tableView?.endUpdates()
                case let .reloadCell(indexPaths):
                    self.tableView?.reloadRows(at: indexPaths, with: .none)
                case let .deleteCell(indexPaths):
                    self.tableView?.deleteRows(at: indexPaths, with: .none)
                case let .insertCell(indexPaths):
                    self.tableView?.insertRows(at: indexPaths, with: .none)
                case let .enable(status):
                    self.tableView?.isUserInteractionEnabled = status
                }
            }).disposed(by: disposeBag)
        }
        
        if let progressHUDAction = progressHUDAction {
            progressHUDAction.drive(onNext: {(type) in
                VLViewControllerConfig.progressHUDSetting(type: type)
            }).disposed(by: disposeBag)
        }
        
        if let alertViewAction = alertViewAction {
            alertViewAction.drive(onNext: {[weak self] (type) in
                guard let self = self else { return }
                VLViewControllerConfig.alertViewActionSetting(type: type, action: {[weak self] (alertActionType) in
                    guard let self = self else { return }
                    self.alerViewAction.accept(alertActionType)
                    self.handle(alertClick: alertActionType)
                })
            }).disposed(by: disposeBag)
        }
        
        if let viewControllerAction = viewControllerAction {
            viewControllerAction.drive(onNext: {[weak self] (type) in
                guard let self = self else { return }
                guard let type = type else { return }
                self.handle(controllerResponse: type)
            }).disposed(by: disposeBag)
        }
    }
    
    @objc func addPullToTopRefresh() {
        VLViewControllerConfig.addPullToTopRefresh(tableView: self.tableView) { [weak self] in
            guard let self = self else { return }
            self.refresh.accept(.top)
        }
    }
    
    @objc func addPullToBottomRefresh() {
        VLViewControllerConfig.addPullToBottomRefresh(tableView: self.tableView) { [weak self] in
            guard let self = self else { return }
            self.refresh.accept(.bottom)
        }
    }
}
// MARK: - viewController控制器配置链
extension VLBaseViewController {
    
    @objc func signalBindViewModel() {
        ///ViewModel signal -> ViewController
        
        ///ViewController signal -> ViewModel
        
        let input = VLBaseViewModel.SignalInput(refresh: self.refresh,
                                                tableViewClickAction: self.tableViewClickAction,
                                                vcLifeRelay: self.vcLifeRelay,
                                                barClickRelay: self.barClickRelay,
                                                alerViewAction: self.alerViewAction,
                                                viewModelReceptionAction: self.viewModelReceptionAction)
        let output = self.viewModel?.signalTransform(input: input)
        self.addDriver(tableViewAction: output?.tableViewAction,
                       progressHUDAction: output?.progressHUDAction,
                       alertViewAction: output?.alertViewAction,
                       viewControllerAction: output?.viewControllerAction)
    }
    
    @objc func configurateUI() {
        self.configurateInstance()
        self.layoutUIInstance()
        self.configurateNavigationBar()
        
        if #available(iOS 11.0, *) {
            self.tableView?.contentInsetAdjustmentBehavior = .automatic
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.backgroundColor = VLHexColor(0xFAFAFA)
    }
    
    @objc func layoutUIInstance() {
        self.view.addSubview(self.bgImageView!)
        self.view.addSubview(self.navigationBar!)
        self.view.addSubview(tableView!)
        
        self.bgImageView?.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view)
        }
        
        tableView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.navigationBar!.snp_bottom)
        })
    }
    
    @objc func configurateInstance() {
        self.bgImageView = UIImageView()
        
        self.navigationBar = VLNavigationBarView(theSuperView: self.view)
        navigationBar?.setStatusBarBackgroundColor(UIColor.white)
        navigationBar?.setNavigationBarBackgroundColor(UIColor.white)
        
        self.tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.tableFooterView = UIView()
        tableView?.backgroundColor = UIColor.clear
        VLGlobalUseCellSet.registerCell(tableView: tableView!)
    }
    
    @objc func configurateNavigationBar() {
        
    }
}
// MARK: - navigationBar自定义配置
extension VLBaseViewController {
    
    @objc func leftBarButtonItemClick(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.barClickRelay.accept(.left)
    }
    
    @objc func rightBarButtonItemClick(_ button: UIButton) {
        self.barClickRelay.accept(.right)
    }
    
    @objc func tableViewDidSelect(item: VLBaseItemViewModel, indexPath: IndexPath) {
        item.selectTypeRelay.bind(to: self.tableViewClickAction).disposed(by: disposeBag)
    }
    
    func setTitle(title: String,
                  titleColor: UIColor = VLHexColor(0x333333),
                  font: UIFont = VLSystemMediumFont(18)) {
        self.navigationBar?.setTitle(title,
                                     textColor: titleColor,
                                     textFont: font)
    }
    
    func setLeftBarItem(text: String,
                        color: UIColor = UIColor.black,
                        font: UIFont = VLSystemMediumFont(16)) {
        self.navigationBar?.setLeftItem(text: text,
                                        color: color,
                                        font: font,
                                        target: self,
                                        method: #selector(leftBarButtonItemClick(_:)))
    }
    
    func setRightBarItem(text: String,
                         color: UIColor = UIColor.black,
                         font: UIFont = VLSystemMediumFont(16)) {
        self.navigationBar?.setRightItem(text: text,
                                         color: color,
                                         font: font,
                                         target: self,
                                         method: #selector(rightBarButtonItemClick(_:)))
    }
    
    func setLeftBarItemImage(_ image: UIImage?) {
        self.navigationBar?.setLeftItemImage(image: image,
                                             target: self,
                                             action: #selector(leftBarButtonItemClick(_:)))
    }
    
    func setRightBarItemImage(_ image: UIImage?) {
        self.navigationBar?.setRightItemImage(image: image,
                                              target: self,
                                              action: #selector(rightBarButtonItemClick(_:)))
    }
}
// MARK: - tableView的Delegate
extension VLBaseViewController: UITableViewDelegate {
    @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let baseModel = viewModel, let item = baseModel.items?[indexPath.section][indexPath.row] {
            return item.cellHeight ?? 0
        }
        return 0.0
    }
    
    @objc func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    @objc func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    @objc func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let baseModel = viewModel, let item = baseModel.items?[indexPath.section][indexPath.row] {
            tableViewDidSelect(item: item, indexPath: indexPath)
        }
    }
    
    @objc func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
}
// MARK: - tableView的DataSource
extension VLBaseViewController: UITableViewDataSource {
    @objc func numberOfSections(in tableView: UITableView) -> Int {
        if let count = viewModel?.items?.count {
            return count
        }
        return 0
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = viewModel?.items?[section] {
            return list.count
        }
        return 0
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemViewModel = viewModel?.items?[indexPath.section][indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(itemViewModel!.itemSupportClassName)) as? VLBaseTableViewCell {
            //cell数据填充
            cell.bind(to: itemViewModel)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }
}

extension UITableView {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else {
            return nil
        }
        if !(view.isKind(of: UITextField.self) || view.isKind(of: UITextView.self)) {
            guard let subviews = view.superview?.subviews else {
                return view
            }
            for subView in subviews {
                //在和输入框同级的点击事件操作中，不隐藏键盘
                if (subView.isKind(of: UITextField.self) || subView.isKind(of: UITextView.self)) {
                    return view
                }
            }
            self.endEditing(true)
        }
        return view
    }
}
