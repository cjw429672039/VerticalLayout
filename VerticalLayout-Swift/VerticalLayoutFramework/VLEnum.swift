//
//  VLEnum.swift
//  
//
//  Created by HarveyChen on 2020/1/6.
//  Copyright © 2020 . All rights reserved.
//

import Foundation

///cell被点击时，所响应的事件类型，被赋值在item上记录类型
protocol SelectType {
    
}
///弹窗按钮响应事件类型
protocol AlertViewActionProtocol {
    
}
///视图事件(退栈入栈，电话等）
protocol ViewControllerActionProtocol {
    
}
///viewModel接收VC传值
protocol ViewModelReceptionActionProtocol {
    
}
///tableView操作
enum TableViewAction {
    case reload
    case reloadHeight
    case reloadCell(indexPaths: [IndexPath])
    case insertCell(indexPaths: [IndexPath])
    case deleteCell(indexPaths: [IndexPath])
    case enable(status: Bool = true)
}
///加载框类型
enum ProgressHUDType {
    case fail(msg: String? = nil, duration: Double = 0.5)
    case success(msg: String? = nil, duration: Double = 0.5)
    case show(msg: String? = nil, duration: Double = 0.5)
    case loading(msg: String? = nil)
    case hidden
    case none
}
///刷新位置
enum RefreshType {
    case top
    case bottom
    case stop
}
///导航栏左右按钮点击
enum LeftRightBarClickType {
    case left
    case right
    case none
}
///控制器生命周期
enum ViewControllerLifeType {
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
    case none
}

///弹窗类型
enum AlertViewAction {
    case single(title: String?, msg: String?, button: String, color: UIColor, action: AlertViewActionProtocol)
    case double(title: String?, msg: String?, firstButton: String, secondButton: String, actions: [AlertViewActionProtocol]? = nil, colors: [UIColor]? = nil)
    case multiple(title: String?, msg: String?, buttons: [String], actions: [AlertViewActionProtocol])
    case none
}
