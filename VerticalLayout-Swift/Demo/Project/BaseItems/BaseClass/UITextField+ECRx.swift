//
//  UITextField+Rx.swift
//  Assureapt
//
//  Created by HarveyChen on 2020/1/3.
//  Copyright © 2020 . All rights reserved.
//
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UITextField {
    
    public var ecAttributedPlaceholder: ControlProperty<NSAttributedString?> {
        return base.rx.ecControlPropertyWithDefaultEvents(
            getter: { textField in
                textField.attributedPlaceholder
            },
            setter: { textField, value in
                // This check is important because setting text value always clears control state
                // including marked text selection which is imporant for proper input
                // when IME input method is used.
                if textField.attributedPlaceholder != value {
                    textField.attributedPlaceholder = value
                }
            }
        )
    }
    
    internal func ecControlPropertyWithDefaultEvents<T>(
        editingEvents: UIControl.Event = [.allEditingEvents, .valueChanged],
        getter: @escaping (Base) -> T,
        setter: @escaping (Base, T) -> Void
        ) -> ControlProperty<T> {
        return controlProperty(
            editingEvents: editingEvents,
            getter: getter,
            setter: setter
        )
    }
    
    public var ecTintColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.tintColor = color
        }
    }
    
    public var ecTextColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.textColor = color
        }
    }
    
    public var ecTextFont: Binder<UIFont?> {
        return Binder(self.base) { view, font in
            view.font = font
        }
    }
    
    public var ecSecureTextEntry: Binder<Bool> {
        return Binder(self.base) { view, value in
            view.isSecureTextEntry = value
        }
    }
    
    public var ecKeyboardType: Binder<UIKeyboardType> {
        return Binder(self.base) { view, value in
            view.keyboardType = value
        }
    }
    
    public func ecBecomeFirstResponder() -> Binder<Bool> {
        return Binder(self.base) { view, status  in
            if status {
                view.becomeFirstResponder()
            } else {
                view.resignFirstResponder()
            }
        }
    }
}
