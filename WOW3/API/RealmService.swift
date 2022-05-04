//
//  RealmService.swift
//  debagJson
//
//  Created by Andrei Mosneag on 27.04.2022.
//

import Foundation
import RealmSwift
//struct FavoriteManager {
//    static let shared = FavoriteManager()
//
//    var realm: Realm {
//        try! Realm ()
//    }
//
//    func saveToFavorite(id: Int) {
//        if checkToFavorite(id: id){
//            try? delete(id: id)
//        } else {
//            try? add(id: id)
//        }
//    }
//
//    func checkToFavorite(id: Int) -> Bool {
//        let objetct = getFavorite (id: id)
//        return objetct != nil
//    }
//    func add(id: Int ) {
//        try! realm.write {
//            let favorite: Favorite = Favorite(id: id)
//            realm.add(favorite)
//        }
//    }
//    func delete (id: Int) throws {
//        try realm.write{
//            if let object = getFavorite (id:id) {
//                realm.delete(object)
//            }
//        }
//    }
//    func getFavorite(id: Int) -> Favorite? {
//        return realm.objects(Favorite.self).filter("id == %@", id).first
//    }
//    func countFavorite() -> Int {
//        let count = realm.objects(Favorite.self).count
//        return count
//    }
//}
//
//struct CartManager {
//    static let shared = CartManager()
//    var realm: Realm {
//        try! Realm()
//    }
//    func checkCart(id: Int) -> Bool {
//        let object = getCard(id:id)
//        return object != nil
//    }
//    func getCard (id: Int)-> CardProduct? {
//        return realm.objects(CardProduct.self).filter("id == %@", id).first
//    }
//
//    func add (id:Int) throws {
//        try realm.write{
//            let cart: CardProduct = CardProduct(id: id)
//            realm.add(cart)
//        }
//    }
//    func delete(id: Int)throws {
//        try realm.write{
//            if let object = getCard(id: id) {
//                realm.delete(object)
//            }
//        }
//    }
//    func saveToCard(id: Int) {
//        if checkCart(id: id) {
//            try? delete(id: id)
//        }else {
//            try? add (id: id)
//        }
//    }
//    func countCard() -> Int {
//        let count = realm.objects(CardProduct.self).count
//        return count
//    }
//
//
//}
//

struct FavoriteManager {
    static let shared = FavoriteManager()
    
    var realm: Realm {
        try! Realm()
    }
    
    func saveToFavorite(id: Int) {
        if checkFavorite(id: id) {
            try? delete(id: id)
        } else {
            try? add(id: id)
        }
    }
    
    func checkFavorite(id: Int) -> Bool {
        let object = getFavorite(id: id)
        return object != nil
    }
    
    func add(id: Int) throws {
        try realm.write {
            let favorite: Favorite = Favorite(id: id)
            realm.add(favorite)
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
    
    func countFavorite() -> Int {
        let count = realm.objects(Favorite.self).count
        return count
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
