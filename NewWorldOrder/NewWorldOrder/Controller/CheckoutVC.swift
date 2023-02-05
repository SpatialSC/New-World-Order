//
//  CheckoutVC.swift
//  NewWorldOrder
//
//  Created by Adam Novak on 2023/02/04.
//

import UIKit

class CheckoutVC: UIViewController {
    
    //MARK: - Properties
    
    var onDismiss: (() -> Void)!
    
    //MARK: - Initializaiton
    
    class func create(onDismiss: @escaping (() -> Void)) -> CheckoutVC {
        let vc = UIStoryboard(name: Constants.SBID.SB.Main, bundle: nil).instantiateViewController(withIdentifier: Constants.SBID.VC.CheckoutVC) as! CheckoutVC
        vc.onDismiss = onDismiss
        return vc
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlack.withAlphaComponent(0.7)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss()
    }
    
}
