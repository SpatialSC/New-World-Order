//
//  CheckoutVC.swift
//  NewWorldOrder
//
//  Created by Adam Novak on 2023/02/04.
//

import UIKit

class CheckoutVC: UIViewController {
    
    //MARK: - Properties
    
    //UI
    @IBOutlet var tableView: UITableView!
    @IBOutlet var purchaseButton: UIButton!
    
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
        view.backgroundColor = .customBlack.withAlphaComponent(0.9)
        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss()
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
        tableView.bounces = false
        tableView.register(UINib(nibName: Constants.SBID.Cell.MenuItemTableCell, bundle: nil), forCellReuseIdentifier: Constants.SBID.Cell.MenuItemTableCell)
    }
    
    @IBAction func purchaseButtonPressed() {
        purchaseButton.loadingIndicator(true)
        Task {
            do {
                try await CartService.shared.purchaseCart()
                DispatchQueue.main.async {
                    self.purchaseButton.loadingIndicator(false)
                    self.dismiss(animated: true)
                }
            } catch {
                
            }
        }
    }
    
}


//MARK: - UITableViewDelegate

extension CheckoutVC: UITableViewDelegate {
    

}

extension CheckoutVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CartService.shared.getCartQuantity() + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "value1")
        let defaultCell = UITableViewCell(style: .default, reuseIdentifier: "default")
        defaultCell.selectionStyle = .none
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        defaultCell.backgroundColor = .clear
        defaultCell.contentView.backgroundColor = .clear
        switch indexPath.row {
        case 0:
            defaultCell.textLabel!.text = "Cart"
            defaultCell.textLabel?.font = AppFont.bold.size(25)
            defaultCell.imageView!.image = UIImage(systemName: "cart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))!
            defaultCell.imageView?.tintColor = .customWhite
            return defaultCell
        case CartService.shared.getCartQuantity()+1:
            cell.textLabel?.font = AppFont.bold.size(20)
            cell.textLabel!.text = "Total"
            cell.detailTextLabel!.text = CartService.shared.getCart().totalPriceString
        default:
            let item = CartService.shared.getCart().items[indexPath.row-1]
            cell.textLabel!.text = item.title
            cell.detailTextLabel!.text = item.priceString
        }
        return cell
    }
    
    
}
