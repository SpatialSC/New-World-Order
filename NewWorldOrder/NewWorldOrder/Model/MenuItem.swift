//
//  MenuItem.swift
//  NewWorldOrder
//
//  Created by Adam Novak on 2023/02/04.
//

import UIKit

struct MenuItem: Equatable, Codable {
    let title: String
    let price: Double
<<<<<<< Updated upstream
    let image: String
=======
    let image: UIImage
    let object: VirtualObject
>>>>>>> Stashed changes
}
//"file:///private/var/containers/Bundle/Application/CAC3B8DF-C09E-4C3C-AC0D-2C787E6A9396/ARKitInteraction.app/Models.scnassets/sticky%20note/sticky%20note.scn"

func getVirtualObject(fileName: String) -> VirtualObject{
    
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    let url = paths.appendingPathComponent("/Users/vikram/New-World-Order/NewWorldOrder/NewWorldOrder/Resources/Models.scnassets/cup/cup.scn")

//    VirtualObject.availableObjects.first!
    
    return VirtualObject(url: url)!
}


let AllMenuItems: [(String, [MenuItem])] = [
    ("Drinks",
<<<<<<< Updated upstream
     [MenuItem(title: "Donut Blend", price: 3.50, image: "matcha"),
      MenuItem(title: "Joe Pro", price: 3.75, image: "matcha"),
      MenuItem(title: "Espresso", price: 3.25, image: "matcha"),
      MenuItem(title: "Macchiato", price: 3.50, image: "matcha"),
      MenuItem(title: "Cortado", price: 3.75, image: "matcha"),
      MenuItem(title: "Cappuccino", price: 4.00, image: "matcha"),
      MenuItem(title: "Americano", price: 3.25, image: "matcha"),
      MenuItem(title: "Latte", price: 4.75, image: "matcha"),
      MenuItem(title: "Dulce Latte", price: 5.00, image: "matcha"),
      MenuItem(title: "Mocha", price: 5.25, image: "matcha"),
      MenuItem(title: "Cold Brew", price: 4.00, image: "matcha"),
      MenuItem(title: "Hot Chocolate", price: 4.75, image: "matcha"),
      MenuItem(title: "Matcha Latte", price: 4.50, image: "matcha"),
     ]
    ),
    ("Breakfast",
     [MenuItem(title: "Breakfast Burrito", price: 8.75, image: "matcha"),
      MenuItem(title: "Breakfast Sandwich", price: 8.75, image: "matcha"),
      MenuItem(title: "Ranchera Steak Burrito", price: 10.00, image: "matcha"),
     ]
    ),
    ("Sandwiches",
     [MenuItem(title: "Pesto Chicken", price: 9.75, image: "matcha"),
      MenuItem(title: "Dulce Club", price: 9.75, image: "matcha"),
      MenuItem(title: "Apple Tuna", price: 9.75, image: "matcha"),
      MenuItem(title: "Turkey Swiss", price: 8.50, image: "matcha"),
      MenuItem(title: "Spicy Korean Cheesesteak", price: 10.25, image: "matcha"),
     ]
    ),
    ("Salads",
     [MenuItem(title: "Peanut Kale", price: 9.50, image: "matcha"),
      MenuItem(title: "Caprese", price: 9.50, image: "matcha"),
      MenuItem(title: "Asian Chicken", price: 10.00, image: "matcha"),
      MenuItem(title: "Cranberry Walnut", price: 9.00, image: "matcha"),
     ]
    ),
    ("Dinner",
     [MenuItem(title: "Bacon Avocado Burger", price: 11.50, image: "matcha"),
      MenuItem(title: "Dulce Burger", price: 9.75, image: "matcha"),
      MenuItem(title: "Tuna Melt", price: 9.50, image: "matcha"),
=======
     [MenuItem(title: "Donut Blend", price: 3.50, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Joe Pro", price: 3.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Espresso", price: 3.25, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Macchiato", price: 3.50, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Cortado", price: 3.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Cappuccino", price: 4.00, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Americano", price: 3.25, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Latte", price: 4.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Dulce Latte", price: 5.00, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Mocha", price: 5.25, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Cold Brew", price: 4.00, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Hot Chocolate", price: 4.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Matcha Latte", price: 4.50, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
     ]
    ),
    ("Breakfast",
     [MenuItem(title: "Breakfast Burrito", price: 8.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Breakfast Sandwich", price: 8.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Ranchera Steak Burrito", price: 10.00, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
     ]
    ),
    ("Sandwiches",
     [MenuItem(title: "Falafel Pita", price: 9.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Dulce Club", price: 9.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Apple Tuna", price: 9.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Turkey Swiss", price: 8.50, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Spicy Korean Cheesesteak", price: 10.25, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
     ]
    ),
    ("Salads",
     [MenuItem(title: "Peanut Kale", price: 9.50, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Caprese", price: 9.50, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Asian Chicken", price: 10.00, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Cranberry Walnut", price: 9.00, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
     ]
    ),
    ("Dinner",
     [MenuItem(title: "Bacon Avocado Burger", price: 11.50, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Dulce Burger", price: 9.75, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
      MenuItem(title: "Tuna Melt", price: 9.50, image: UIImage(named: "matcha")!, object: getVirtualObject(fileName: "cup.scn")),
>>>>>>> Stashed changes
     ]
    ),
]
