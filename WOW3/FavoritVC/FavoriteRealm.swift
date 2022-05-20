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
    @Persisted var label: String = ""
    @Persisted var descriptionLable: String = ""
    @Persisted var price: Int = 0
    @Persisted var image: String = ""
    
   
    convenience init(id: Int, label: String, descriptionLabel: String, price: Int, image: String) {
        self.init()
        self.id = id
        self.label = label
        self.descriptionLable = descriptionLabel
        self.price = price
        self.image = image
    }
}
