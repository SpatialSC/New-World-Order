//
//  UIViewController+MistShareActivity.swift
//  mist-ios
//
//  Created by Adam Monterey on 7/7/22.
//

import UIKit

protocol ShareActivityDelegate {
    func presentShareActivityVC()
}

extension UIViewController {
    
    func presentShareAppActivity() {
        let objectsToShare: [Any] = [Constants.appStoreLink]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        present(activityVC, animated: true)
    }
}
