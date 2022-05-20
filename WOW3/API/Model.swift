//
//  Model.swift
//  debagJson
//
//  Created by Andrei Mosneag on 06.04.2022.
//

import Foundation
struct Lesson: Decodable {
    let id: Int?
    let name: String?
    let date: Date?
    let image : String?
    let link : String?
    let comments: [Comments]?
}
struct Comments: Decodable {
    let id: Int?
    let text: String?
    let date: Date?
    let user: User?
}
struct User: Decodable {
    let id: Int?
    let name: String?
    let text: String?
    let date: Date?
    let gender: Gender?
    enum Gender: String, Decodable {
        case male
        case female
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

