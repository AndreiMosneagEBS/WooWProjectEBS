//
//  FavoriteSections.swift
//  WOW3
//
//  Created by Andrei Mosneag on 16.05.2022.
//

import Foundation
struct FavoriteSections {
    enum SectionType {
        case header
        case product
    }
    enum CellType {
        case header
        case favorites (model: Favorite)
    }
    struct Section {
        var type: SectionType
        var cell:[CellType] = []
    }
}
