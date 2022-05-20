//
//  File.swift
//  debagJson
//
//  Created by Andrei Mosneag on 08.04.2022.
//

import Foundation

struct ProductCellType {
    
    enum SectionType{
        case header
        case product
    }
    enum CellType {
        case header
        case product(model: Products)
//        case loading
    
    }
    
    struct Sections  {
        var type: SectionType
        var cell: [CellType] = []
    }
}
