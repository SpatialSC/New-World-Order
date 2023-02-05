//
//  UINavigationController+SwipeBack.swift
//  scdatingclub-ios
//
//  Created by Adam Novak on 2023/01/08.
//

import UIKit

extension UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
}
