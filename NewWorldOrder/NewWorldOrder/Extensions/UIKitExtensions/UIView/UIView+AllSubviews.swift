//
//  UIView+AllSubviews.swift
//  cleanmessage-ios
//
//  Created by Adam Novak on 2023/01/30.
//

import UIKit

extension UIView {
    var allSubviews: [UIView] {
        return self.subviews.flatMap { [$0] + $0.allSubviews }
    }
}
