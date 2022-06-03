//
//  FavoritesSection.swift
//  WOW3
//
//  Created by Andrei Mosneag on 17.05.2022.
//

import Foundation
import Foundation

struct FavoriteSections  {
    enum SectionType {
        case header
        case product
    }
    enum CellType {
        case header
        case favorites (model: Products)
    }
    struct Section {
        var type: SectionType
        var cell:[CellType] = []
    }
}
