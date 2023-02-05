//
//  UIViewController+OpenURL.swift
//  mist-ios
//
//  Created by Adam Monterey on 7/7/22.
//

import Foundation
import SafariServices

extension UIViewController {
    
    func openURL(_ url: URL) {
        let webViewController = SFSafariViewController(url: url)
        webViewController.preferredControlTintColor = .systemBlue
        present(webViewController, animated: true)
    }
    
    func openMailtoURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
