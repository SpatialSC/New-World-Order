////
////  UpdateAvailableVC.swift
////  scdatingclub-ios
////
////  Created by Adam Novak on 2022/12/30.
////
//
//import UIKit
//
//class UpdateAvailableVC: UIViewController {
//
//    @IBOutlet var updateButton: SimpleButton!
//    @IBOutlet var dismissButton: SimpleButton!
//    @IBOutlet var titleLabel: UILabel!
//
//    @IBOutlet var featureView1: FeatureView!
//    @IBOutlet var featureView2: FeatureView!
//    @IBOutlet var featureView3: FeatureView!
//    var featureViews: [FeatureView] {
//        return [featureView1, featureView2, featureView3]
//    }
//    var features: [Feature] {
//        return Constants.updateAvailableFeatures.newFeatures
//    }
//    var isMandatory: Bool!
//
//    //MARK: - Initialization
//
//
//    class func create(isMandatory: Bool) -> UpdateAvailableVC {
//        let vc = UIStoryboard(name: Constants.SBID.SB.Misc, bundle: nil).instantiateViewController(withIdentifier: Constants.SBID.VC.UpdateAvailable) as! UpdateAvailableVC
//        vc.isMandatory = isMandatory
//        return vc
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        titleLabel.font = AppFont.bold.size(30)
//        setupButtons()
//        for i in 0..<features.count {
//            featureViews[i].configure(features[i])
//        }
//        for x in features.count..<featureViews.count {
//            featureViews[x].isHidden = true
//        }
//        DeviceService.shared.didReceiveNewUpdateAlert(forVersion: Constants.updateAvailableVersion)
//    }
//
//    //MARK: - Setup
//
//    func setupButtons() {
//        updateButton.internalButton.addTarget(self, action: #selector(updateButtonDidPressed), for: .touchUpInside)
//        dismissButton.internalButton.addTarget(self, action: #selector(dismissButtonDidPressed), for: .touchUpInside)
//        updateButton.configure(title: "update", systemImage: "")
//        dismissButton.configure(title: "later", systemImage: "")
//        dismissButton.alpha = 0.5
//        dismissButton.isHidden = isMandatory
//    }
//
//    //MARK: - Interaction
//
//    @objc func updateButtonDidPressed() {
//        openURL(Constants.appStoreLink)
//    }
//
//    @objc func dismissButtonDidPressed() {
//        dismiss(animated: true)
//    }
//
//}
