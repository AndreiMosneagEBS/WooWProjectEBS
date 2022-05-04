//
//  Pagination.swift
//  debagJson
//
//  Created by Andrei Mosneag on 11.04.2022.
//

import Foundation

struct Pagination {
    var count: Int = 0
    var totalPages: Int = 0
    var perPage: Int = 10
    var currentPage: Int = 1
    var isLastPage: Bool = false
}

