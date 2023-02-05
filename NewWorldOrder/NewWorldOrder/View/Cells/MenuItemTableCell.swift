//
//  MenuItemTableCell.swift
//  NewWorldOrder
//
//  Created by Adam Novak on 2023/02/04.
//

import UIKit

class MenuItemTableCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        bgView.backgroundColor = .customBlack.withAlphaComponent(0.65)
        bgView.roundCornersViaCornerRadius(radius: 15)
    }
    
    func configure(title: String, price: Double, image: UIImage) {
        itemTitleLabel.text = title
        itemPriceLabel.text = "$\(price)"
        itemImageView.image = image
    }
    
}
