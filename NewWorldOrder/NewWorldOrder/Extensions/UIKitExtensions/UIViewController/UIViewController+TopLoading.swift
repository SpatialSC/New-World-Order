//
//  UIViewController+TopLoading.swift
//  scdatingclub-ios
//
//  Created by Adam Novak on 2023/01/28.
//

import UIKit

extension UIViewController {
    
    func createTopLoadingView() -> UIView {
        let topLoadingView = UIView()
        view.addSubview(topLoadingView)
        view.bringSubviewToFront(topLoadingView)
        topLoadingView.backgroundColor = .black.withAlphaComponent(0.5)
        topLoadingView.translatesAutoresizingMaskIntoConstraints = false
        topLoadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLoadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topLoadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topLoadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        let loadingIndicator = UIActivityIndicatorView()
        topLoadingView.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loadingIndicator.startAnimating()
        loadingIndicator.color = .white
        return topLoadingView
    }
    
}
