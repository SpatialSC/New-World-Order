//
//  ViewController.swift
//  NewWorldOrder
//
//  Created by Vikram Agrawal on 2/4/23.
//

import UIKit
import RealityKit
import ARKit
import SceneKit
import QuartzCore

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
    
//    @IBOutlet var arView: ARView!
    @IBOutlet var sceneView: VirtualObjectARView!
    let coachingOverlay = ARCoachingOverlayView()
    var focusSquare = FocusSquare()
    
    /// The view controller that displays the status and "restart experience" UI.
//    lazy var statusViewController: StatusViewController = {
//        return children.lazy.compactMap({ $0 as? StatusViewController }).first!
//    }()
    
    /// The view controller that displays the virtual object selection menu.
    var objectsViewController: VirtualObjectSelectionViewController?
    
    // MARK: - ARKit Configuration Properties
    
    /// A type which manages gesture manipulation of virtual content in the scene.
    lazy var virtualObjectInteraction = VirtualObjectInteraction(sceneView: sceneView, viewController: self)
    
    /// Coordinates the loading and unloading of reference nodes for virtual objects.
    let virtualObjectLoader = VirtualObjectLoader()
    
    /// Marks if the AR experience is available for restart.
    var isRestartAvailable = true
    
    /// A serial queue used to coordinate adding or removing nodes from the scene.
    let updateQueue = DispatchQueue(label: "com.example.apple-samplecode.arkitexample.serialSceneKitQueue")
    
    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        return sceneView.session
    }
    
    @IBOutlet var maskView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIStackView!
    @IBOutlet var headerBgView: UIView!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerMoreButton: UIButton!
    @IBOutlet var headerCartButton: UIButton!
    @IBOutlet var scrollLeftButton: UIButton!
    @IBOutlet var scrollRightButton: UIButton!
    
    lazy var fullBackgroundGradientLayer: CAGradientLayer = {
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.black.cgColor]
        gradientLayer.opacity = 0.53
        sceneView.layer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapArView)))

        setupHeader()
        setupAr()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true

        // Start the `ARSession`.
        resetTracking()
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.pause()
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
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 90))

        tableView.register(UINib(nibName: Constants.SBID.Cell.MenuItemTableCell, bundle: nil), forCellReuseIdentifier: Constants.SBID.Cell.MenuItemTableCell)
    }
    
    func setupHeader() {
        headerImageView.applyMediumShadow()
        headerMoreButton.applyMediumShadow()
        headerCartButton.applyMediumShadow()
        
        applyGradientLayers()
        toggleFullBackgroundShadow(hidden: false)
        
        scrollLeftButton.alpha = 0
        scrollLeftButton.applyMediumShadow()
        scrollRightButton.alpha = 0
        scrollRightButton.applyMediumShadow()
    }
    
    func setupAr() {
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Set up coaching overlay.
        setupCoachingOverlay()

        // Set up scene content.
        sceneView.scene.rootNode.addChildNode(focusSquare)

        // Hook up status view controller callback(s).
//        statusViewController.restartExperienceHandler = { [unowned self] in
//            self.restartExperience()
//        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showVirtualObjectSelectionViewController))
        // Set the delegate to ensure this gesture is only used when there are no virtual objects in the scene.
        tapGesture.delegate = self
        sceneView.addGestureRecognizer(tapGesture)
    }
        
    func applyGradientLayers() {
        let gradientLayerFromTop:CAGradientLayer = CAGradientLayer()
        gradientLayerFromTop.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 2)
        gradientLayerFromTop.colors = [UIColor.black.cgColor,UIColor.clear.cgColor]
        gradientLayerFromTop.opacity = 0.5
        sceneView.layer.addSublayer(gradientLayerFromTop)
        
        let transparentGradientLayer = CAGradientLayer()
        transparentGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        transparentGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        transparentGradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
        transparentGradientLayer.locations = [0, 0.1, 1]
        transparentGradientLayer.frame = CGRect(x: 0, y: tableView.bounds.minY, width: view.bounds.width, height: view.bounds.height)
        maskView.layer.mask = transparentGradientLayer

        let gradientLayerFromBottom:CAGradientLayer = CAGradientLayer()
        gradientLayerFromBottom.frame = CGRect(x: 0, y: view.frame.size.height - (view.frame.size.height/2), width: view.frame.size.width, height: view.frame.size.height / 2)
        gradientLayerFromBottom.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayerFromBottom.opacity = 0.5
        sceneView.layer.addSublayer(gradientLayerFromBottom)
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
    
    func toggleFullBackgroundShadow(hidden: Bool) {
        fullBackgroundGradientLayer.isHidden = hidden
    }
    
}

//MARK: - UITableViewDelegate

extension MenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.deselectRow(at: indexPath, animated: false)
        currentlyVisibleItem = AllMenuItems[indexPath.section].1[indexPath.row]
        presentItemSheetVC(currentlyVisibleItem!)
        toggleFullBackgroundShadow(hidden: true)
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
            toggleFullBackgroundShadow(hidden: false)
        default:
            break
        }
    }
    
    func handleChildWillDismiss() {

    }
    
    func handleChildDidDismiss() {
        currentlyVisibleItem = nil
        toggleScrollButtons(hidden: true)
        toggleFullBackgroundShadow(hidden: false)
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
        menuItemCell.configure(title: menuItem.title, price: menuItem.price, image: UIImage(named: menuItem.image)!)
        return menuItemCell
    }
    
    
}
