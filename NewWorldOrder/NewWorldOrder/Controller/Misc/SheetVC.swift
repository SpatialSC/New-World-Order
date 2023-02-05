////
////  SheetViewController.swift
////  scdatingclub-ios
////
////  Created by Adam Novak on 2023/01/09.
////
//
//import UIKit
//
////protocol SheetVCDelegate {
////    func handleSuccessfulBlock()
////}
//
//struct SheetButton {
//    let title: String
//    let systemImageName: String
//    let handler: () -> Void
//}
//
//class SheetVC: UIViewController {
//        
//    @IBOutlet weak var backgroundView: UIView!
//    @IBOutlet var stackView: UIStackView!
//    
//    var sheetButtons: [SheetButton]!
//        
//    class func create(sheetButtons: [SheetButton]) -> SheetVC {
//        let vc = UIStoryboard(name: Constants.SBID.SB.Misc, bundle: nil).instantiateViewController(withIdentifier: Constants.SBID.VC.Sheet) as! SheetVC
//        vc.sheetButtons = sheetButtons
//        return vc
//    }
//    
//    override func loadView() {
//        super.loadView()
//        self.modalPresentationStyle = .overCurrentContext
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupBackgroundView()
//        setupStackView()
//    }
//    
//    func setupBackgroundView() {
//        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(closeButtonDidPressed))
//        view.addGestureRecognizer(dismissTap)
//        view.backgroundColor = .clear
//        backgroundView.backgroundColor = .customWhite
//        backgroundView.layer.cornerRadius = 10
//        backgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//    }
//    
//    func setupStackView() {
//        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
//        sheetButtons.forEach { sheetButton in
//            let button = SimpleButton()
//            button.configure(title: sheetButton.title, systemImage: sheetButton.systemImageName)
//            button.internalButton.addAction(UIAction(handler: { action in
//                sheetButton.handler()
//            }), for: .touchUpInside)
//            
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
//            stackView.addArrangedSubview(button)
//        }
//    }
//    
//    @objc func closeButtonDidPressed() {
//        dismiss(animated: true)
//    }
//}
