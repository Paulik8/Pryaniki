//
//  Main.swift
//  Pryaniki
//
//  Created by Paulik on 14.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

// MARK: - MainModelDto
struct MainModelDto: Codable {
    let data: [Datum]
    let view: [String]
}

// MARK: - MainModel
struct MainModel: Codable {
    let data: [Datum]
    let view: [MainModelViews]
}

// MARK: - Datum
struct Datum: Codable {
    let name: MainModelViews
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}

