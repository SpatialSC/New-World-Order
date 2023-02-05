//
//  AppStoreReviewManager.swift
//  timewellspent-ios
//
//  Created by Adam Novak on 2022/11/20.
//

import Foundation
import StoreKit

enum AppStoreReviewManager {
    
  static func requestReviewIfAppropriate() {
      if !DeviceService.shared.hasRatedApp() {
          DeviceService.shared.didRateApp()
          SKStoreReviewController.requestReviewInCurrentScene()
      }
  }
    
    static func offerViewPromptUponUserRequest() {
        SKStoreReviewController.requestReviewInCurrentScene()
    }
    
//    static func handleLeaveReview() {
//        guard let productURL = Constants.downloadLink else { return }
//        var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
//        components?.queryItems = [ URLQueryItem(name: "action", value: "write-review") ]
//        guard let writeReviewURL = components?.url else { return }
//        UIApplication.shared.open(writeReviewURL)
//    }
    
}

extension SKStoreReviewController {
    
    public static func requestReviewInCurrentScene() {
        
        if #available(iOS 14.0, *) {if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                requestReview(in: scene)
            }
        } else {
            requestReview()
        }
        
    }
    
}
