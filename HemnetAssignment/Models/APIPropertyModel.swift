//
//  APIPropertyModel.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-27.
//

import Foundation

struct PropertyResponse: Codable {
    let items: [Item]
}

enum ItemType: String, Codable {
    case highlightedProperty = "HighlightedProperty"
    case property = "Property"
    case area = "Area"
}

struct Item: Codable, Identifiable {
    let type: ItemType
    let id: String
    let askingPrice: Int?
    let monthlyFee: Int?
    let municipality: String?
    let area: String
    let daysSincePublish: Int?
    let livingArea: Int?
    let numberOfRooms: Int?
    let streetAddress: String?
    let image: String
    let ratingFormatted: String?
    let averagePrice: Int?
}
