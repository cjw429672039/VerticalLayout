//
//  VerifyEmailViewModel.swift
//  
//
//  Created 
//  Copyright © . All rights reserved.
//

import UIKit

enum VerifyEmailControllerAction: ViewControllerActionProtocol {
    case getSupport(email: String)
    case changePassword(code: String, email: String)
}

class VerifyEmailViewModel: VLBaseViewModel {
    private var resetItem: DoubleButtonItemViewModel?
    private var codeInputItem: CodeInputItemViewModel?
    private var verifyCodeErrorItem: TextItemViewModel?
    private var codeInputEmptyItem: EmptyItemViewModel?
    private var emailCode: String?
    private var email: String?
    private var resendTimer: Timer?
    private var resendTimerCount: Int = 0
    
    init(email: String) {
        self.email = email
        
        super.init()
    }
    
    override func signalTransform(input: VLBaseViewModel.SignalInput) -> VLBaseViewModel.SignalOutput {
        // 验证码输入开始
        self.codeInputItem?.textEditEventRelay.subscribe(onNext: {[weak self] (event) in
            guard let self = self else { return }
            guard event == .editingDidBegin else { return }
            self.verifyCodeErrorMessage(show: false)
            self.codeInputItem?.codeInputErrorRelay.accept(false)
        }).disposed(by: disposeBag)
        //验证码输入结束
        self.codeInputItem?.codeInputEndRelay.subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
            guard let text = self.codeInputItem?.codeText.value, text.count >= 4 else { return }
            self.verifyEmailCodeNetworkRequest()
        }).disposed(by: disposeBag)
        // 重发邮件
        self.resetItem?.leftButtonAction.subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
            self.verifyCodeErrorMessage(show: false)
            self.resendEmailNetworkRequest()
        }).disposed(by: disposeBag)
        // 没收到邮件处理
        self.resetItem?.rightButtonAction.subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
            guard let email = self.email else { return }
            self.viewControllerAction.accept(VerifyEmailControllerAction.getSupport(email: email))
        }).disposed(by: disposeBag)
        
        return super.signalTransform(input: input)
    }
}

extension VerifyEmailViewModel {
    //items配置以及其他数据配置(在init调用)
    override func configurateInstance() {
        super.configurateInstance()
        
        self.resetItem = DoubleButtonItemViewModel(lineLeftText: "Resend Email", lineRightText: "Didn't receive an email?")
        self.codeInputItem = CodeInputItemViewModel()
        self.verifyCodeErrorItem = TextItemViewModel(errorHintText: "Incorrect verification code")
        self.codeInputEmptyItem = EmptyItemViewModel(VLScaleHeight(28))
        
        self.items = [[EmptyItemViewModel(VLScaleHeight(20)),
                       TextItemViewModel(topTitle: "Verify Email"),
                       EmptyItemViewModel(VLScaleHeight(20)),
                       TextItemViewModel(hintText: "We sent an email to："),
                       EmptyItemViewModel(VLScaleHeight(8)),
                       TextItemViewModel(middleTitle: self.email),
                       EmptyItemViewModel(VLScaleHeight(20)),
                       TextItemViewModel(hintText: "Enter the verification code sent to your email address. The code is valid only for 15 minutes."),
                       EmptyItemViewModel(VLScaleHeight(10)),
                       self.codeInputItem!,
                       self.codeInputEmptyItem!]]
        self.startResendTimer()
    }
}

// MARK: - 网络请求
extension VerifyEmailViewModel {
    public func resendEmailNetworkRequest() {
        self.showResendItem(show: false)
        self.startResendTimer()

        self.progressHUDAction.accept(.loading())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let  num = arc4random()
            switch num % 2 {
            case 0:
                break
            case 1:
                self.verifyCodeErrorMessage(show: false)
                self.verifyCodeErrorItem?.update(text: "Fail", bottomSpace: -VLScaleHeight(12))
                self.verifyCodeErrorMessage(show: true)
                self.codeInputItem?.codeInputErrorRelay.accept(true)
            default:
                break
            }
            self.progressHUDAction.accept(.hidden)
        }
    }
    
    public func verifyEmailCodeNetworkRequest() {
        guard let code = self.codeInputItem?.codeText.value, let email = self.email  else { return }
        self.progressHUDAction.accept(.loading())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let  num = arc4random()
            switch num % 2 {
            case 0:
                self.viewControllerAction.accept(VerifyEmailControllerAction.changePassword(code: code, email: email))
            case 1:
                self.verifyCodeErrorMessage(show: false)
                self.verifyCodeErrorItem?.update(text: "Fail")
                self.verifyCodeErrorMessage(show: true)
                self.codeInputItem?.codeInputErrorRelay.accept(true)
            default:
                break
            }
            self.progressHUDAction.accept(.hidden)
        }
    }
}

extension VerifyEmailViewModel {
    private func startResendTimer() {
        resendTimer = Timer.scheduledTimer(timeInterval: 1,
                                           target: self,
                                           selector: #selector(resendTimerCountDown),
                                           userInfo: nil,
                                           repeats: true)
    }

    private func stopResendTimer() {
        self.resendTimer?.invalidate()
        self.resendTimerCount = 0
    }

    @objc func resendTimerCountDown() {
        self.resendTimerCount += 1
        if self.resendTimerCount >= 60 {
            self.stopResendTimer()
            self.showResendItem(show: true)
        }
    }

    private func showResendItem(show: Bool) {
        if show {
            if !self.items![0].contains(self.resetItem!) {
                let index = self.items![0].firstIndex(of: self.codeInputEmptyItem!)! + 1
                self.items![0].insert(self.resetItem!, at: index)
                self.tableViewAction.accept(.insertCell(indexPaths: [IndexPath(row: index, section: 0)]))
            }
        } else {
            if self.items![0].contains(self.resetItem!) {
                let index = self.items![0].firstIndex(of: self.resetItem!)!
                self.items![0].remove(at: index)
                self.tableViewAction.accept(.deleteCell(indexPaths: [IndexPath(row: index, section: 0)]))
            }
        }
    }
    
    private func verifyCodeErrorMessage(show: Bool) {
        if show {
            if !self.items![0].contains(self.verifyCodeErrorItem!) {
                let index = self.items![0].firstIndex(of: self.codeInputItem!)! + 1
                self.items![0].insert(self.verifyCodeErrorItem!, at: index)
                self.tableViewAction.accept(.insertCell(indexPaths: [IndexPath(row: index, section: 0)]))
            }
        } else {
            if self.items![0].contains(self.verifyCodeErrorItem!) {
                let index = self.items![0].firstIndex(of: self.verifyCodeErrorItem!)!
                self.items![0].remove(at: index)
                self.tableViewAction.accept(.deleteCell(indexPaths: [IndexPath(row: index, section: 0)]))
            }
        }
    }
}
