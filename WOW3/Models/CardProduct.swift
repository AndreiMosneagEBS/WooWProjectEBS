//
//  CardProduct.swift
//  debagJson
//
//  Created by Andrei Mosneag on 27.04.2022.
//

import Foundation
import RealmSwift

class CartProduct: Object {
    @Persisted(primaryKey: true)
    var id: Int
    
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
}
