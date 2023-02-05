//
//  UIViewController+OpenMailApp.swift
//  scdatingclub-ios
//
//  Created by Adam Novak on 2023/01/16.
//

import UIKit

extension UIViewController {
    
    func presentOpenMailAppAlert() {
        if UIApplication.shared.canOpenURL(Constants.gmailLink) {
            UIApplication.shared.open(Constants.gmailLink, options: [:], completionHandler: nil)
        } else if UIApplication.shared.canOpenURL(Constants.defaultMailLink) {
            UIApplication.shared.open(Constants.defaultMailLink, options: [:], completionHandler: nil)
        }
    }
    
}
