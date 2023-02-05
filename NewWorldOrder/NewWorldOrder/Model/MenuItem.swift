//
//  MenuItem.swift
//  NewWorldOrder
//
//  Created by Adam Novak on 2023/02/04.
//

import UIKit

struct MenuItem: Equatable {
    let title: String
    let price: Double
    let image: UIImage
}

let AllMenuItems: [(String, [MenuItem])] = [
    ("Drinks",
     [MenuItem(title: "Donut Blend", price: 3.50, image: UIImage(named: "matcha")!),
      MenuItem(title: "Joe Pro", price: 3.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Espresso", price: 3.25, image: UIImage(named: "matcha")!),
      MenuItem(title: "Macchiato", price: 3.50, image: UIImage(named: "matcha")!),
      MenuItem(title: "Cortado", price: 3.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Cappuccino", price: 4.00, image: UIImage(named: "matcha")!),
      MenuItem(title: "Americano", price: 3.25, image: UIImage(named: "matcha")!),
      MenuItem(title: "Latte", price: 4.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Dulce Latte", price: 5.00, image: UIImage(named: "matcha")!),
      MenuItem(title: "Mocha", price: 5.25, image: UIImage(named: "matcha")!),
      MenuItem(title: "Cold Brew", price: 4.00, image: UIImage(named: "matcha")!),
      MenuItem(title: "Hot Chocolate", price: 4.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Matcha Latte", price: 4.50, image: UIImage(named: "matcha")!),
     ]
    ),
    ("Breakfast",
     [MenuItem(title: "Breakfast Burrito", price: 8.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Breakfast Sandwich", price: 8.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Ranchera Steak Burrito", price: 10.00, image: UIImage(named: "matcha")!),
     ]
    ),
    ("Sandwiches",
     [MenuItem(title: "Pesto Chicken", price: 9.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Dulce Club", price: 9.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Apple Tuna", price: 9.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Turkey Swiss", price: 8.50, image: UIImage(named: "matcha")!),
      MenuItem(title: "Spicy Korean Cheesesteak", price: 10.25, image: UIImage(named: "matcha")!),
     ]
    ),
    ("Salads",
     [MenuItem(title: "Peanut Kale", price: 9.50, image: UIImage(named: "matcha")!),
      MenuItem(title: "Caprese", price: 9.50, image: UIImage(named: "matcha")!),
      MenuItem(title: "Asian Chicken", price: 10.00, image: UIImage(named: "matcha")!),
      MenuItem(title: "Cranberry Walnut", price: 9.00, image: UIImage(named: "matcha")!),
     ]
    ),
    ("Dinner",
     [MenuItem(title: "Bacon Avocado Burger", price: 11.50, image: UIImage(named: "matcha")!),
      MenuItem(title: "Dulce Burger", price: 9.75, image: UIImage(named: "matcha")!),
      MenuItem(title: "Tuna Melt", price: 9.50, image: UIImage(named: "matcha")!),
     ]
    ),
]
