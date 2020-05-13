//
//  Extensions.swift
//  KRProgressHUD
//
//  Copyright © 2017 Krimpedance. All rights reserved.
//

import UIKit

// MARK: - UIApplication extension ------------

extension UIApplication {
    func topViewController(_ base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? keyWindow?.rootViewController
        if let top = (base as? UINavigationController)?.topViewController {
            return topViewController(top)
        }
        if let selected = (base as? UITabBarController)?.selectedViewController {
            return topViewController(selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

// MARK: - NSLayoutConstraint extension ------------

extension NSLayoutConstraint {
    convenience init(item view1: Any,
                     attribute attr1: NSLayoutConstraint.Attribute,
                     relatedBy relation: NSLayoutConstraint.Relation = .equal,
                     toItem view2: Any? = nil,
                     attribute attr2: NSLayoutConstraint.Attribute? = nil,
                     constant: CGFloat = 0) {
        self.init(item: view1, attribute: attr1, relatedBy: relation, toItem: view2, attribute: attr2 ?? attr1, multiplier: 1.0, constant: constant)
    }
}

extension CAGradientLayer {
    func color(point: CGPoint) -> UIColor {
        var pixel: [UInt8] = [0, 0, 0, 0]
        let context = CGContext(
            data: &pixel,
            width: 1,
            height: 1,
            bitsPerComponent: 8,
            bytesPerRow: 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )

        context!.translateBy(x: -point.x, y: -point.y)
        render(in: context!)

        let red: CGFloat = CGFloat(pixel[0])/255.0
        let green: CGFloat = CGFloat(pixel[1])/255.0
        let blue: CGFloat = CGFloat(pixel[2])/255.0
        let alpha: CGFloat = CGFloat(pixel[3])/255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
