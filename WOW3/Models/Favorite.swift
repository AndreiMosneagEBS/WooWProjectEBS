//
//  Favorite.swift
//  debagJson
//
//  Created by Andrei Mosneag on 27.04.2022.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @Persisted(primaryKey: true)
    @objc dynamic var id: Int
    @objc dynamic var label: String = ""
    @objc dynamic var descriptionLable: String = ""
    @objc dynamic var price: Int = 0
   
    convenience init(id: Int, label: String, descriptionLabel: String, price: Int) {
        self.init()
        self.id = id
        self.label = label
        self.descriptionLable = descriptionLabel
        self.price = price
        
    }
}
