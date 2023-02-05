//
//  OkViewController.swift
//  mist-ios
//
//  Created by Adam Novak on 2022/03/13.
//

import UIKit
import MapKit

typealias PinMapModalCompletionHandler = ((String?) -> Void)

//modal with a custom size
//https://stackoverflow.com/questions/54737884/changing-the-size-of-a-modal-view-controller

class ItemSheetVC: CustomSheetViewController {

    //MARK: - Properties
    
    var completionHandler: PinMapModalCompletionHandler!
    var menuItem: MenuItem!

    //UI
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    //MARK: - Initialization
    
    class func create(item: MenuItem, sheetDelegate: UISheetPresentationControllerDelegate, dismissDelegate: childDismissDelegate) -> ItemSheetVC {
        let vc = UIStoryboard(name: Constants.SBID.SB.Main, bundle: nil).instantiateViewController(withIdentifier: Constants.SBID.VC.ItemSheetVC) as! ItemSheetVC
        vc.menuItem = item
        vc.sheetDismissDelegate = dismissDelegate
        vc.sheetDelegate = sheetDelegate
        vc.loadViewIfNeeded() //doesnt work without this function call
        return vc
    }

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rerender(with: menuItem)
//        selectButton.layer.cornerRadius = 5
//        reselectButton.layer.cornerRadius = 5
        containingView.layer.cornerRadius = 15
        view.backgroundColor = .customBlack.withAlphaComponent(0.5)

        isModalInPresentation = true //prevents the VC from being dismissed by the user

        let wasTapped = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        view.addGestureRecognizer(wasTapped)

        setupSheet(prefersGrabberVisible: true,
                   detents: [Constants.Detents.zil, Constants.Detents.s, Constants.Detents.l],
                   largestUndimmedDetentIdentifier: "xl")
        toggleSheetSizeTo(sheetSize: "s", animated: false)
    }

    //MARK: - User Interaction

    @IBAction func selectButtonDidPressed(_ sender: UIButton) {
        
    }

    @IBAction func reselectButtonDidPressed(_ sender: UIButton) {
        
    }
    
    //MARK: - Public Interface
    
    func rerender(with menuItem: MenuItem) {
        self.menuItem = menuItem
        titleLabel.text = menuItem.title
        priceLabel.text = "$\(menuItem.price)"
        descriptionLabel.text = "GOOD SHIT"
    }


    //MARK: - Helpers

    @objc func handleBackgroundTap() {
        //not also hiding the side buttons rn. the programmatic call below doesnt perform the "sheetSizeDidAdjust" delegate call like the user slide
//        if mySheetPresentationController.selectedDetentIdentifier?.rawValue == "s" {
//            toggleSheetSizeTo(sheetSize: "l", animated: true)
//        }
    }

}
