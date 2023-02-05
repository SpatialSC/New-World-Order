//
//  CartService.swift
//  NewWorldOrder
//
//  Created by Adam Novak on 2023/02/04.
//

import Foundation

class CartService: NSObject {
    
    static var shared = CartService()
    private let LOCAL_FILE_APPENDING_PATH = "cart.json"
    private var localFileLocation: URL!
    private var cart: Cart!
    
    //MARK: - Initializer
    
    //private initializer because there will only ever be one instance of UserService, the singleton
    private override init() {
        super.init()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        localFileLocation = documentsDirectory.appendingPathComponent(LOCAL_FILE_APPENDING_PATH)
        if FileManager.default.fileExists(atPath: localFileLocation.path) {
            loadFromFilesystem()
        } else {
            cart = Cart(items: [])
            Task { await saveToFilesystem() }
        }
    }
    
    //MARK: - Getters
    
    func getCart() -> Cart {
        return cart
    }
    
    func getCartQuantity() -> Int {
        return cart.items.count
    }
    
    //MARK: - Setters
    
    func addItemToCart(_ itemToAdd: MenuItem) {
        cart.items.append(itemToAdd)
    }
    
    func removeItemFromCart(_ itemToRemove: MenuItem) {
        cart.items.removeFirstAppearanceOf(object: itemToRemove)
    }
    
    func purchaseCart() async throws {
        try await Task.sleep(nanoseconds: UInt64(1.5 * Double(NSEC_PER_SEC)))
        emptyCart()
    }
    
    //MARK: - Helpers
    
    private func emptyCart() {
        cart = Cart(items: [])
    }
    
    //MARK: - Filesystem
    
    func saveToFilesystem() async {
        do {
            let encoder = JSONEncoder()
            let data: Data = try encoder.encode(cart)
            let jsonString = String(data: data, encoding: .utf8)!
            try jsonString.write(to: self.localFileLocation, atomically: true, encoding: .utf8)
        } catch {
            print("COULD NOT SAVE: \(error)")
        }
    }

    func loadFromFilesystem() {
        do {
            let data = try Data(contentsOf: self.localFileLocation)
            cart = try JSONDecoder().decode(Cart.self, from: data)
        } catch {
            print("COULD NOT LOAD: \(error)")
        }
    }
    
    func eraseData() {
        do {
            try FileManager.default.removeItem(at: self.localFileLocation)
        } catch {
            print("\(error)")
        }
    }
}
