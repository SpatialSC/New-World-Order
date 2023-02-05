//
//  MoreVC.swift
//  NewWorldOrder
//
//  Created by Adam Novak on 2023/02/04.
//

import UIKit

class MoreVC: UIViewController {
    
    //MARK: - Properties
    
    var onDismiss: (() -> Void)!
    
    //MARK: - Initializaiton
    
    class func create(onDismiss: @escaping (() -> Void)) -> MoreVC {
        let vc = UIStoryboard(name: Constants.SBID.SB.Main, bundle: nil).instantiateViewController(withIdentifier: Constants.SBID.VC.MoreVC) as! MoreVC
        vc.onDismiss = onDismiss
        return vc
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss()
    }
    
}
