//
//  RealmService.swift
//  debagJson
//
//  Created by Andrei Mosneag on 27.04.2022.
//

import Foundation
import RealmSwift


struct FavoriteManager {
    static let shared = FavoriteManager()
    
    var realm: Realm {
        try! Realm()
    }
    
    func saveToFavorite(product: Products) {
        if checkFavorite(id: product.id) {
            try? delete(id: product.id)
        } else {
            try? add(model: product)
        }
    }
    
    func checkFavorite(id: Int) -> Bool {
        let object = getFavorite(id: id)
        return object != nil
    }
    
    func add(model: Products) throws {
        try realm.write {
            let favorite: Favorite = Favorite(id: model.id, label: model.name , descriptionLabel: model.details, price: model.price)
            realm.add(favorite)
            print(model.name)
        }
    }
    
    func delete(id: Int) throws {
        try realm.write {
            if let object = getFavorite(id: id) {
                realm.delete(object)
            }
        }
    }
    
    func getFavorite(id: Int) -> Favorite? {
        return realm.objects(Favorite.self).filter("id == %@", id).first
    }
    
    func getAllFavorites() -> [Favorite] {
//        print(try! queryObjects(with: Favorite.self).map({ $0 }))
        let favorites = realm.objects(Favorite.self).map({$0})
        print(favorites)
        return realm.objects(Favorite.self).map({$0})
    }
    
    func countFavorite() -> Int {
        let count = realm.objects(Favorite.self).count
        return count
    }
    
    func queryObjects<T: Object>(with type: T.Type) throws -> Results<T> {
          let realm = try Realm()
          return realm.objects(T.self)
      }
}

struct CartManager {
    static let shared = CartManager()
   
    var realm: Realm {
        try! Realm()
    }
    
    func checkCart(id: Int) -> Bool {
        let object = getCart(id: id)
        return object != nil
    }
    
    func getCart(id: Int) -> CartProduct? {
        return realm.objects(CartProduct.self).filter("id == %@", id).first
    }
    
    func add(id: Int) throws {
        try realm.write {
            let cart: CartProduct = CartProduct(id: id)
            realm.add(cart)
        }
    }
    
    func delete(id: Int) throws {
        try realm.write {
            if let object = getCart(id: id) {
                realm.delete(object)
            }
        }
    }
    
    func saveToCart(id: Int) {
        if checkCart(id: id) {
            try? delete(id: id)
        } else {
            try? add(id: id)
        }
    }
    
    func countCart() -> Int {
        let count = realm.objects(CartProduct.self).count
        return count
    }
}
