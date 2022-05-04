//
//  ProductSection.swift
//  debagJson
//
//  Created by Andrei Mosneag on 27.04.2022.
//

import Foundation

struct Sections {
    enum SectionType {
        case header
        case product
    }
    enum CellType {
        case header
        case product(model: Products)
    }
    struct Section {
        var type: SectionType
        var cell:[CellType] = []
    }
}
