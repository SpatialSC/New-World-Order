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
    let image: String
    let ingredients: String
    var priceString: String {
        return "$\(price)\(price % 10 == 0 ? "0" : "")"
    }
}

let AllMenuItems: [(String, [MenuItem])] = [
    ("Drinks",
     [MenuItem(title: "Americano", price: 3.25, image: "matcha", ingredients: "Espresso Coffee, Water"),
      MenuItem(title: "Ice Latte", price: 4.75, image: "icelatte", ingredients: "Espresso Coffee, Milk of Choice, Vanilla Syrup, Ice"),
      MenuItem(title: "Mocha", price: 5.25, image: "matcha", ingredients: "Espresso Roast, Milk of Choice, Mocha Sauce, Whipped Cream"),
      MenuItem(title: "Cold Brew", price: 4.00, image: "coldbrew", ingredients: "Steeped Coffee, Sweet Cream, Ice"),
      MenuItem(title: "Hot Chocolate", price: 4.75, image: "hotchocolate", ingredients: "Milk of Choice, Cocoa powder, Chocolate, Vanilla Extract, Sugar"),
      MenuItem(title: "Matcha Latte", price: 4.50, image: "matcha", ingredients: "Matcha Powder, Hot Water, Milk of Choice, Honey, Ice"),
     ]
    ),
    ("Breakfast",
     [MenuItem(title: "Breakfast Burrito", price: 8.75, image: "breakfast-burrito", ingredients: "Tortilla, Avocados, Tomatoes, Mushrooms, Shallots, Garlic, Lime Juice, Eggs, Sausage, Monterey Jack Cheese, Seasonings (Cumin, Cilantro, Salt, Pepper)"),
      MenuItem(title: "Breakfast Sandwich", price: 8.75, image: "breakfast-sandwich-2", ingredients: "Croissant, Bacon, Eggs, Mushrooms, American Cheese, Avocados, Seasonings (Salt, Pepper)"),
      MenuItem(title: "Ranchera Steak Burrito", price: 10.00, image: "matcha", ingredients: "Tortilla, Steak, Pico de Gallo (Tomatoes, Onions, Peppers, Lime Juice, Cilantro, Black Beans, Cheddar Cheese, Rice"),
     ]
    ),
    ("Sandwiches",
     [MenuItem(title: "Pesto Chicken", price: 9.75, image: "matcha", ingredients: "Bread Rolls, Chicken, Mozzarella Slices, Tomatoes, Pesto"),
      MenuItem(title: "Dulce Club", price: 9.75, image: "matcha", ingredients: "Baguette Bread, Turkey, Bacon, Tomatoes, Lettuce, Avocado, Mustard, Mayo"),
      MenuItem(title: "Apple Tuna", price: 9.75, image: "matcha", ingredients: "Sliced Bread, Tuna, Celery, Onion, Relish, Chopped Apple, Lettuce, Mayo"),
      MenuItem(title: "Turkey Swiss", price: 8.50, image: "turkey sandwich", ingredients: "French Bread, Roast Turkey, Swiss Cheese, Tomatoes, Onion, Mustard, Mayo"),
      MenuItem(title: "Spicy Korean Cheesesteak", price: 10.25, image: "matcha", ingredients: "Hoagie Buns, Bulgogi sliced beef, Kimchi, Onions, Scallions, Garlic, Provolone Cheese, Gochujang Mayo"),
      MenuItem(title: "Falafel Pita", price: 10.25, image: "matcha", ingredients: "Pita Bread, Falafel, Hummus, Eggplant, Pickles, Cabbage, Carrots, Tomato, Onion, Garlic Dressing, Skhug"),
     ]
    ),
    ("Salads",
     [MenuItem(title: "Peanut Kale", price: 9.50, image: "matcha", ingredients: "Kale, Onions, Garlic, Peanut Butter, Rice Vinegar, Tamari, Rice Syrup, Honey"),
      MenuItem(title: "Caprese", price: 9.50, image: "caprese salad", ingredients: "Basil, Tomatoes, Mozerella, Balsamic Vinegar, Olive Oil"),
      MenuItem(title: "Asian Chicken", price: 10.00, image: "asian chicken salad", ingredients: "Cabbage, Lettuce, Shredded Chicken, Carrots, Red Peppers, Shallots, Rice Vinegar, Soy Sauce, Garlic, Sesame Oil, Sesame Seeds, Mandarin Oranges"),
      MenuItem(title: "Cranberry Walnut", price: 9.00, image: "cranberry walnut salad", ingredients: "Lettuce, Spinach, Walnuts, Red Onion, Cranberries, Goat Cheese, Balsamic Vinaigrette"),
     ]
    ),
    ("Dinner",
     [MenuItem(title: "Bacon Avocado Burger", price: 11.50, image: "matcha", ingredients: "Toasted Burger Bun, Bacon, Ground Beef Burger Meat, Lettuce, Tomatoes, Cheddar Cheese, Onions, Avocado, Mayo"),
      MenuItem(title: "Vegan Burger", price: 9.75, image: "matcha", ingredients: "Toasted Burger Buns, Spinach, Roasted Portobello Mushrooms, Onions, Garlic, Shallots, Avocado"),
      MenuItem(title: "Tuna Melt", price: 9.50, image: "matcha", ingredients: "Sourdough Bread, Tuna, Spinach, Celery, Onion, Tomato, Pickles, Red Peppers, Tomatoes, Cheddar Cheese, Lemon Juice, Mayo"),
     ]
    ),
]
