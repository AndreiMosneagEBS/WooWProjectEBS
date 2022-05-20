//
//  ApiData.swift
//  debagJson
//
//  Created by Andrei Mosneag on 07.04.2022.
//

import Foundation


struct Welcome: Codable {
    var count: Int?
    var totalPages: Int?
    var perPage: Int?
    var currentPage: Int?
    var results: [Result]?
    
}


struct Result: Codable {
    var category: Category?
    var name: String?
    var details: String?
    var size: String?
    var colour: String?
    var price: Int?
    var soldCount: Int?
    var id: Int?
}

struct Category: Codable {
    var name: String?
    var icon: String?
    var id: Int?
}
