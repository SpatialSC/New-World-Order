//
//  UIViewController+SBTransition.swift
//  mist-ios
//
//  Created by Adam Novak on 2022/05/25.
//

import UIKit

//extension UIViewController {
    // Reference: https://stackoverflow.com/questions/41144523/swap-rootviewcontroller-with-animation
@MainActor
func transitionToStoryboard(storyboardID: String,
                            viewControllerID: String? = nil,
                            duration: Double,
                            completion: @escaping (Bool) -> Void = { _ in } ) {
    let sb = UIStoryboard(name: storyboardID, bundle: nil)
    let homeVC = (viewControllerID != nil) ? sb.instantiateViewController(withIdentifier: viewControllerID!) : sb.instantiateInitialViewController()
    
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
    let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return }
    
    // Set the new rootViewController of the window.
    // Calling "UIView.transition" below will animate the swap.
    window.rootViewController = homeVC

    // A mask of options indicating how you want to perform the animations.
    let options: UIView.AnimationOptions = .transitionCrossDissolve

    // The duration of the transition animation, measured in seconds.
    let duration: TimeInterval = duration

    
    // Creates a transition animation.
    // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
    UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: completion)
}

@MainActor
func transitionToViewController(_ viewController: UIViewController,
                            duration: Double,
                            completion: @escaping (Bool) -> Void = { _ in } ) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
    let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return }
    
    // Set the new rootViewController of the window.
    // Calling "UIView.transition" below will animate the swap.
    window.rootViewController = viewController

    // A mask of options indicating how you want to perform the animations.
    let options: UIView.AnimationOptions = .transitionCrossDissolve

    // The duration of the transition animation, measured in seconds.
    let duration: TimeInterval = duration
    
    // Creates a transition animation.
    // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
    UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: completion)
}

//@MainActor
//func transitionToAuth() {
//    let sb = UIStoryboard(name: Constants.SBID.SB.Auth, bundle: nil)
//    let homeVC = sb.instantiateInitialViewController()
//    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//    let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return }
//    window.rootViewController = homeVC
//
//    let options: UIView.AnimationOptions = .transitionCrossDissolve
//    let duration: TimeInterval = 0.5
//    UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
//}

@MainActor
func transitionToHomeAndRequestPermissions(completion: @escaping () -> Void) {
    let sb = UIStoryboard(name: Constants.SBID.SB.Main, bundle: nil)
    let homeVC = sb.instantiateInitialViewController()
//    let navVC = homeVC.viewControllers![0] as! UINavigationController
//    let exploreMapVC = navVC.visibleViewController! as! ExploreViewController
    
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
    let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else {
        return
    }
    
    // Set the new rootViewController of the window.
    // Calling "UIView.transition" below will animate the swap.
    window.rootViewController = homeVC

    // A mask of options indicating how you want to perform the animations.
    let options: UIView.AnimationOptions = .transitionCrossDissolve

    // The duration of the transition animation, measured in seconds.
    let duration: TimeInterval = 0.5

    
    // Creates a transition animation.
    // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
    UIView.transition(with: window, duration: duration, options: options, animations: {}) { _ in
        completion()
    }
}
//}
