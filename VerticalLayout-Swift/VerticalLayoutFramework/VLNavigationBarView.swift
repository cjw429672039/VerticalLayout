//
//  VLNavigationBarView.swift
//  
//
//  Created by HarveyChen on 2019/12/3.
//  Copyright © 2019 GHZ. All rights reserved.
//

import UIKit

// MARK: - 导航栏
class VLNavigationBarView: UIView {
    
    let itemSpaceWidth = 10.0
    var backgroundImageView: UIImageView!
    var titleLabel: UILabel!
    private var navigationBar: UIView!
    private var statusBar: UIView!
    private var contentTitleView: UIView!
    private var leftBarButtonView: UIView!
    private var rightBarButtonView: UIView!
    private var lineView: UIView!
    
    init( theSuperView: UIView) {
        
        let frame = CGRect(x: 0.0, y: 0.0, width: theSuperView.frame.width, height: VLConst.VLNavigationHeight)
        super.init(frame: frame)
        self.center = CGPoint(x: theSuperView.frame.width/2, y: self.center.y)
        
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundImageView = UIImageView(frame: self.bounds)
        backgroundImageView.contentMode = UIView.ContentMode.scaleToFill
        self.addSubview(self.backgroundImageView)
        
        self.statusBar = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: VLConst.VLStatusBarHeight))
        self.addSubview(self.statusBar)
        
        self.navigationBar = UIView(frame: CGRect(x: 0.0, y: VLConst.VLStatusBarHeight, width: self.bounds.width, height: VLConst.VLNavigationBarHeight))
        self .addSubview(self.navigationBar)
        
        self.leftBarButtonView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width/3.0, height: VLConst.VLNavigationBarHeight))
        self.navigationBar.addSubview(self.leftBarButtonView)
        
        self.rightBarButtonView = UIView(frame: CGRect(x: self.bounds.width*2.0/3.0, y: 0.0, width: self.bounds.width/3.0, height: VLConst.VLNavigationBarHeight))
        self.navigationBar.addSubview(self.rightBarButtonView)
        
        self.contentTitleView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.width * 2/3.0, height: VLConst.VLNavigationBarHeight))
        contentTitleView.center = CGPoint(x: self.bounds.width/2.0, y: VLConst.VLNavigationBarHeight/2.0)
        self.navigationBar.addSubview(self.contentTitleView)
        
        self.lineView = UIView(frame: CGRect(x: 0.0, y: VLConst.VLNavigationHeight, width: self.bounds.width, height: 1.0))
        lineView.backgroundColor = VLConst.VLHexColor(0xE9EAEA)
        lineView.layer.shadowColor = lineView.backgroundColor?.cgColor
        lineView.layer.shadowOffset = CGSize(width: self.bounds.width, height: 5.0)
        lineView.layer.shadowOpacity = 5.0
        lineView.isHidden = true
        self.addSubview(self.lineView)
        
        self.titleLabel = UILabel(frame: self.contentTitleView.bounds)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 17.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 导航栏对应配置方法
extension VLNavigationBarView {
    //导航栏背景图片
    func setBackgroundImage(_ image: UIImage?) {
        self.backgroundImageView?.image = image
    }
    //导航栏文字设置
    func setTitle(_ title: String?, textColor color: UIColor?, textFont font: UIFont?) {
        self.titleLabel?.text = title
        self.titleLabel?.textColor = color
        self.titleLabel?.font = font
        self.titleLabel?.isHidden = title == nil ? true : false
        
        if self.titleLabel!.superview == nil {
            self.contentTitleView?.addSubview(self.titleLabel!)
        }
    }
    
    func setTitleView(_ titleView: UIView) {
        for view in self.contentTitleView.subviews {
            view.removeFromSuperview()
        }
        titleView.center = CGPoint(x: self.contentTitleView.bounds.width/2.0, y: self.contentTitleView.bounds.height/2.0)
        self.contentTitleView.addSubview(titleView)
    }
    
    func setLeftBarButtonItem(_ leftItem: UIView) {
        if leftItem.frame.width < 30.0 {
            leftItem.frame = CGRect(x: 0, y: 0, width: 30.0, height: leftItem.frame.height)
        }
        
        if leftItem.frame.height < 40.0 {
            leftItem.frame = CGRect(x: 0, y: 0, width: leftItem.frame.width, height: 40.0)
        }
        
        for view in self.leftBarButtonView?.subviews ?? [] {
            view.removeFromSuperview()
        }
        leftItem.frame = CGRect(x: CGFloat(self.itemSpaceWidth), y: 0.0, width: leftItem.frame.width, height: leftItem.frame.height)
        self.leftBarButtonView?.addSubview(leftItem)
    }
    
    func setRightBarButtonItem(_ rightItem: UIView) {
        if rightItem.frame.width < 30.0 {
            rightItem.frame = CGRect(x: 0, y: 0, width: 30.0, height: rightItem.frame.height)
        }
        
        if rightItem.frame.height < 40.0 {
            rightItem.frame = CGRect(x: 0, y: 0, width: rightItem.frame.width, height: 40.0)
        }
        for view in self.rightBarButtonView?.subviews ?? [] {
            view.removeFromSuperview()
        }
        rightItem.frame = CGRect(x: CGFloat(self.rightBarButtonView.bounds.width - rightItem.frame.width - CGFloat(self.itemSpaceWidth)),
                                 y: 0,
                                 width: rightItem.frame.width,
                                 height: rightItem.frame.height)
        rightItem.center = CGPoint(x: rightItem.center.x, y: self.rightBarButtonView.bounds.height/2.0)
        self.rightBarButtonView.addSubview(rightItem)
    }
    
    func setNavigationBarBackgroundColor(_ color: UIColor) {
        self.navigationBar?.backgroundColor = color
    }
    
    func setStatusBarBackgroundColor(_ color: UIColor) {
        self.statusBar?.backgroundColor = color
    }
    
    func setLineView(color: UIColor, hidden: Bool = false) {
        self.lineView?.isHidden = hidden
        self.lineView?.backgroundColor = color
    }
    
    func setLeftItem(text: String? = "", color: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 17.0), target: AnyObject? = nil, method: Selector) {
        let button = UIButton()
        button.setTitle(text, for: UIControl.State.normal)
        button.setTitleColor(color, for: UIControl.State.normal)
        button.titleLabel?.font = font
        button.sizeToFit()
        button.addTarget(target, action: method, for: UIControl.Event.touchUpInside)
        setLeftBarButtonItem(button)
    }
    
    func setLeftItemImage(image: UIImage?, target: AnyObject, action: Selector) {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        setLeftBarButtonItem(button)
    }
    
    func setRightItem(text: String? = "", color: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 17.0), target: AnyObject? = nil, method: Selector) {
        let button = UIButton()
        button.setTitle(text, for: UIControl.State.normal)
        button.setTitleColor(color, for: UIControl.State.normal)
        button.titleLabel?.font = font
        button.sizeToFit()
        button.addTarget(target, action: method, for: UIControl.Event.touchUpInside)
        setRightBarButtonItem(button)
    }
    
    func setRightItemImage(image: UIImage?, target: AnyObject, action: Selector) {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        setRightBarButtonItem(button)
    }
}

// MARK: - 使用到的全局变量
struct VLConst {
    static let VLStatusBarHeight: CGFloat = VLConst.VLIsIPhoneX() ? 44.0 : 20.0
    static let VLNavigationHeight: CGFloat = VLConst.VLStatusBarHeight + VLNavigationBarHeight
    static let VLNavigationBarHeight: CGFloat = 44.0
    //判断手机是否是iPhoneX
    static func VLIsIPhoneX() -> Bool {
        if #available(iOS 11.0, *) {
            if UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20.0 > CGFloat(20.0) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    static func VLHexColor(_ rgbValue: Int) -> UIColor {
        return UIColor(red: (CGFloat((rgbValue & 0xFF0000) >> 16))/255.0, green: (CGFloat(((rgbValue & 0xFF00) >> 8)))/255.0, blue: (CGFloat((rgbValue & 0xFF)))/255.0, alpha: 1.0)
    }
}
