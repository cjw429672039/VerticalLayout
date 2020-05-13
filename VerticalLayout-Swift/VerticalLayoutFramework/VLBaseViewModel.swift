//
//  VLBaseViewModel.swift
//  
//
//  Created by HarveyChen on 2019/12/25.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import RxSwift
import Foundation

typealias VLItemList = [VLBaseItemViewModel]

class VLBaseViewModel: NSObject {
    //数据源
    var items: [VLItemList]?
    /// Rx资源回收包
    let disposeBag = DisposeBag()
    //tableView上拉和下拉刷新(已经与VC绑定)
    let tableViewAction = PublishRelay<TableViewAction>()
    //loading消息提示(已经与VC绑定)
    let progressHUDAction = PublishRelay<ProgressHUDType>()
    //aler弹窗提示(已经与VC绑定)
    let alertViewAction = PublishRelay<AlertViewAction>()
    //viewModel传输给VC的事件(已经与VC绑定)
    let viewControllerAction = PublishRelay<ViewControllerActionProtocol?>()
    
    struct SignalInput {
        let refresh: PublishRelay<RefreshType>
        let tableViewClickAction: PublishRelay<SelectType?>
        let vcLifeRelay: PublishRelay<ViewControllerLifeType>
        let barClickRelay: PublishRelay<LeftRightBarClickType>
        let alerViewAction: PublishRelay<AlertViewActionProtocol>
        let viewModelReceptionAction: PublishRelay<ViewModelReceptionActionProtocol>
    }
    
    struct SignalOutput {
        let tableViewAction: Driver<TableViewAction>
        let progressHUDAction: Driver<ProgressHUDType>
        let alertViewAction: Driver<AlertViewAction>
        let viewControllerAction: Driver<ViewControllerActionProtocol?>
    }
    
    func signalTransform(input: VLBaseViewModel.SignalInput) -> VLBaseViewModel.SignalOutput {
        input.alerViewAction.subscribe(onNext: {[weak self] (type) in
            guard let self = self else { return }
            self.handle(alertClick: type)
        }).disposed(by: disposeBag)
        
        input.refresh.subscribe(onNext: {[weak self] (type) in
            guard let self = self else { return }
            self.handle(refreshClick: type)
        }).disposed(by: disposeBag)
        
        input.viewModelReceptionAction.subscribe(onNext: {[weak self] (type) in
            guard let self = self else { return }
            self.handle(viewModelReception: type)
        }).disposed(by: disposeBag)
        
        input.barClickRelay.subscribe(onNext: {[weak self] (type) in
            guard let self = self else { return }
            self.handle(barClick: type)
        }).disposed(by: disposeBag)
        
        input.vcLifeRelay.subscribe(onNext: {[weak self] (type) in
            guard let self = self else { return }
            self.handle(vcLife: type)
        }).disposed(by: disposeBag)
        
        input.tableViewClickAction.subscribe(onNext: {[weak self] (type) in
            guard let self = self else { return }
            guard let type = type else { return }
            self.handle(tableClick: type)
        }).disposed(by: disposeBag)
        return SignalOutput(tableViewAction: self.tableViewAction.asDriver(onErrorJustReturn: .reload),
                            progressHUDAction: self.progressHUDAction.asDriver(onErrorJustReturn: .none),
                            alertViewAction: self.alertViewAction.asDriver(onErrorJustReturn: .none),
                            viewControllerAction: self.viewControllerAction.asDriver(onErrorJustReturn: nil))
    }
    
    func handle(alertClick action: AlertViewActionProtocol) {
        
    }
    
    func handle(refreshClick action: RefreshType) {
        
    }
    
    func handle(viewModelReception action: ViewModelReceptionActionProtocol) {
        
    }
    
    func handle(barClick action: LeftRightBarClickType) {
        
    }
    
    func handle(vcLife action: ViewControllerLifeType) {
        
    }
    
    func handle(tableClick action: SelectType) {
        
    }
    
    override init() {
        super.init()
        
        configurateInstance()
    }
    
    deinit {
        print("")
        print("")
        print("页面释放了\(self.classForCoder)")
        print("")
        print("")
    }
}

extension VLBaseViewModel {
    
    @objc func configurateInstance() {
        
    }
}

extension Reactive where Base: VLBaseViewModel {
    var viewControllerAction: Binder<ViewControllerActionProtocol?> {
        return Binder(self.base) { viewModel, action in
            viewModel.viewControllerAction.accept(action)
        }
    }
    
    var tableViewAction: Binder<TableViewAction> {
        return Binder(self.base) { viewModel, action in
            viewModel.tableViewAction.accept(action)
        }
    }
    
    var progressHUDAction: Binder<ProgressHUDType> {
        return Binder(self.base) { viewModel, action in
            viewModel.progressHUDAction.accept(action)
        }
    }
    
    var alertViewAction: Binder<AlertViewAction> {
        return Binder(self.base) { viewModel, action in
            viewModel.alertViewAction.accept(action)
        }
    }
}
