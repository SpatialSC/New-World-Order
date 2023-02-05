//
//  ViewController.swift
//  NewWorldOrder
//
//  Created by Vikram Agrawal on 2/4/23.
//

import UIKit
import RealityKit
import ARKit

class MenuVC: UIViewController {
    
    //MARK: - Properties
    
    //UI
    var itemSheetVC: ItemSheetVC?
    var currentlyVisibleItem: MenuItem? {
        didSet {
            DispatchQueue.main.async {
                self.rerenderVisibleMenuItem()
            }
        }
    }
    
    @IBOutlet var arView: ARView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var headerView: UIStackView!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerMoreButton: UIButton!
    @IBOutlet var headerCartButton: UIButton!
    @IBOutlet var scrollLeftButton: UIButton!
    @IBOutlet var scrollRightButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapArView)))

        setupHeader()
        setupArCamera()
        setupTableView()
    }
    
    //MARK: - Setup
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.delaysContentTouches = false //responsive button highlight
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))

        tableView.register(UINib(nibName: Constants.SBID.Cell.MenuItemTableCell, bundle: nil), forCellReuseIdentifier: Constants.SBID.Cell.MenuItemTableCell)
    }
    
    func setupHeader() {
        headerImageView.applyMediumShadow()
        headerMoreButton.applyMediumShadow()
        headerCartButton.applyMediumShadow()
    }
    
    func setupArCamera() {
        applyGradientUnderneathNavbar()
        scrollLeftButton.alpha = 0
        scrollLeftButton.applyMediumShadow()
        scrollRightButton.alpha = 0
        scrollRightButton.applyMediumShadow()
    }
    
    
    func applyGradientUnderneathNavbar() {
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 2)
        gradientLayer.colors = [UIColor.black.cgColor,UIColor.clear.cgColor]
        gradientLayer.opacity = 0.5
        arView.layer.addSublayer(gradientLayer)
        
        let gradientLayerFromBottom:CAGradientLayer = CAGradientLayer()
        gradientLayerFromBottom.frame = CGRect(x: 0, y: view.frame.size.height - (view.frame.size.height/2), width: view.frame.size.width, height: view.frame.size.height / 2)
        gradientLayerFromBottom.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayerFromBottom.opacity = 0.5
        arView.layer.addSublayer(gradientLayerFromBottom)
    }
    
    //MARK: - User Interaction
    
    @IBAction func checkoutButtonPressed() {
        itemSheetVC?.dismiss(animated: false)
        toggleTableView(hidden: true)
        toggleHeader(hidden: true)
        let checkoutVc = CheckoutVC.create(onDismiss: {
            self.toggleTableView(hidden: false)
            self.toggleHeader(hidden: false)
        })
        present(checkoutVc, animated: true)
    }
    
    @IBAction func moreButtonPressed() {
        itemSheetVC?.dismiss(animated: false)
        toggleTableView(hidden: true)
        let moreVc = MoreVC.create(onDismiss: {
            self.toggleTableView(hidden: false)
        })
        present(moreVc, animated: true)
    }
    
    @IBAction func scrollLeftButtonPressed() {
        guard let currentlyVisibleItem else { return }
        for categoryIndex in 0..<AllMenuItems.count {
            let category = AllMenuItems[categoryIndex]
            if let itemIndex = category.1.firstIndex(where: { $0 == currentlyVisibleItem }) {
                if itemIndex == 0 {
                    if categoryIndex == 0 {
                        self.currentlyVisibleItem = AllMenuItems.last!.1.last!
                    } else {
                        self.currentlyVisibleItem = AllMenuItems[categoryIndex-1].1.last!
                    }
                } else {
                    self.currentlyVisibleItem = AllMenuItems[categoryIndex].1[itemIndex-1]
                }
                return
            }
        }
    }
    
    @IBAction func scrollRightButtonPressed() {
        guard let currentlyVisibleItem else { return }
        for categoryIndex in 0..<AllMenuItems.count {
            let category = AllMenuItems[categoryIndex]
            if let itemIndex = category.1.firstIndex(where: { $0 == currentlyVisibleItem }) {
                if itemIndex == category.1.count-1 {
                    if categoryIndex == AllMenuItems.count-1 {
                        self.currentlyVisibleItem = AllMenuItems[0].1.first!
                    } else {
                        self.currentlyVisibleItem = AllMenuItems[categoryIndex+1].1.first!
                    }
                } else {
                    self.currentlyVisibleItem = AllMenuItems[categoryIndex].1[itemIndex+1]
                }
                return
            }
        }
    }

    
    //MARK: - Helpers
    
    func rerenderVisibleMenuItem() {
        guard let currentlyVisibleItem else { return }
        itemSheetVC?.rerender(with: currentlyVisibleItem)
        
        //TODO: rerender the ar view on the screen
    }
    
    func presentItemSheetVC(_ item: MenuItem) {
        itemSheetVC = ItemSheetVC.create(item: item, sheetDelegate: self, dismissDelegate: self)
        guard let itemSheetVC else { return }
        present(itemSheetVC, animated: true)
        toggleTableView(hidden: true)
        toggleScrollButtons(hidden: false)
    }
    
    func dismissItemSheetVC() {
        currentlyVisibleItem = nil
        itemSheetVC!.dismiss(animated: false)
        toggleTableView(hidden: false)
        toggleScrollButtons(hidden: true)
    }
    
    func toggleTableView(hidden: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.tableView.alpha = hidden ? 0 : 1
        }
    }
    
    func toggleHeader(hidden: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.headerView.alpha = hidden ? 0 : 1
        }
    }
    
    func toggleScrollButtons(hidden: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.scrollLeftButton.alpha = hidden ? 0 : 1
            self.scrollRightButton.alpha = hidden ? 0 : 1
        }
    }
    
}

//MARK: - UITableViewDelegate

extension MenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.deselectRow(at: indexPath, animated: false)
        currentlyVisibleItem = AllMenuItems[indexPath.section].1[indexPath.row]
        presentItemSheetVC(currentlyVisibleItem!)
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return AllMenuItems[section].0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    //Fix font
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = AppFont.bold.size(25)
        header.textLabel?.text = header.textLabel?.text?.lowercased().capitalizeFirstLetter()
        header.textLabel?.textColor = .customWhite
    }

}

//MARK: - SheetDelegate

extension MenuVC: UISheetPresentationControllerDelegate, childDismissDelegate {
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        let sheetID = sheetPresentationController.selectedDetentIdentifier?.rawValue
        switch sheetID {
        case "l":
            toggleScrollButtons(hidden: true)
        case "s":
            toggleScrollButtons(hidden: false)
        case "zil":
            dismissItemSheetVC()
            toggleScrollButtons(hidden: true)
        default:
            break
        }
    }
    
    func handleChildWillDismiss() {

    }
    
    func handleChildDidDismiss() {
        currentlyVisibleItem = nil
        toggleScrollButtons(hidden: true)
    }
    
}

extension MenuVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        AllMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllMenuItems[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItemCell = self.tableView.dequeueReusableCell(withIdentifier: Constants.SBID.Cell.MenuItemTableCell, for: indexPath) as! MenuItemTableCell
        let menuItem = AllMenuItems[indexPath.section].1[indexPath.row]
        menuItemCell.configure(title: menuItem.title, price: menuItem.price, image: menuItem.image)
        return menuItemCell
    }
    
    
}
