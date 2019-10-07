//  
//  HomeModel.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation

// MARK: - ProductResponseElement
struct ProductResponseElement: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let category: [Category]?
    let productPromo: [ProductPromo]?
}

// MARK: - Category
struct Category: Codable {
    let imageURL: String?
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case id, name
    }
}

// MARK: - ProductPromo
struct ProductPromo: Codable {
    let id: String?
    let imageURL: String?
    let title, productPromoDescription, price: String?
    let loved: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case title
        case productPromoDescription = "description"
        case price, loved
    }
}

typealias ProductResponse = [ProductResponseElement]
