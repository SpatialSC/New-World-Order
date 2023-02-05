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
    @IBOutlet var arView: ARView!
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapArView)))

        
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
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        tableView.register(UINib(nibName: Constants.SBID.Cell.MenuItemTableCell, bundle: nil), forCellReuseIdentifier: Constants.SBID.Cell.MenuItemTableCell)
    }
    
    //MARK: - Helpers
    
    func presentItemSheetVC(_ item: MenuItem) {
        itemSheetVC = ItemSheetVC.create(item: item, sheetDelegate: self)
        guard let itemSheetVC else { return }
        present(itemSheetVC, animated: true)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.tableView.alpha = 0
        }
    }
    
    func dismissItemSheetVC() {
        itemSheetVC!.dismiss(animated: false)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.tableView.alpha = 1
        }
    }
    
}

//MARK: - UITableViewDelegate

extension MenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = AllMenuItems[0]
        presentItemSheetVC(item)
        return nil
    }

}

//MARK: - SheetDelegate

extension MenuVC: UISheetPresentationControllerDelegate {
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        let sheetID = sheetPresentationController.selectedDetentIdentifier?.rawValue

        if sheetID == "zil" {
            dismissItemSheetVC()
        }
    }
    
}

extension MenuVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllMenuItems.count + 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItemCell = self.tableView.dequeueReusableCell(withIdentifier: Constants.SBID.Cell.MenuItemTableCell, for: indexPath) as! MenuItemTableCell
        let menuItem = AllMenuItems[0]
        menuItemCell.configure(title: menuItem.title, price: menuItem.price, image: menuItem.image)
        return menuItemCell
    }
    
    
}
