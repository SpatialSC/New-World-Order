//
//  MenuItem.swift
//  NewWorldOrder
//
//  Created by Adam Novak on 2023/02/04.
//

import UIKit

struct MenuItem {
    let title: String
    let price: Double
    let image: UIImage
}

let AllMenuItems: [MenuItem] = [
    MenuItem(title: "Dulce Matcha", price: 6.25, image: UIImage(named: "matcha")!)
]
