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

extension Item {
    
    static let mockData: [Item] = [
        Item(type: .highlightedProperty, id: "1234567890", askingPrice: 2650000, monthlyFee: nil, municipality: "Gällivare kommun", area: "Heden", daysSincePublish: 1, livingArea: 120, numberOfRooms: 5, streetAddress: "Mockvägen 1", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg", ratingFormatted: nil, averagePrice: nil),
        Item(type: .property, id: "1234567891", askingPrice: 6950000, monthlyFee: 3498, municipality: "Stockholm", area: "Nedre Gärdet", daysSincePublish: 10, livingArea: 85, numberOfRooms: 3, streetAddress: "Mockvägen 2", image: "https://upload.wikimedia.org/wikipedia/commons/8/8f/Arkitekt_Peder_Magnussen_hus_H%C3%B8nefoss_HDR.jpg", ratingFormatted: nil, averagePrice: nil),
        Item(type: .area, id: "1234567892", askingPrice: nil, monthlyFee: nil, municipality: nil, area: "Stockholm", daysSincePublish: nil, livingArea: nil, numberOfRooms: nil, streetAddress: nil, image: "https://i.imgur.com/v6GDnCG.png", ratingFormatted: "4.5/5", averagePrice: 50100),
        Item(type: .property, id: "1234567893", askingPrice: 1150000, monthlyFee: 2298, municipality: "Uppsala kommun", area: "Kvarngärdet", daysSincePublish: 12, livingArea: 29, numberOfRooms: 1, streetAddress: "Mockvägen 4", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Bertha_Petterssons_hus_01.jpg/800px-Bertha_Petterssons_hus_01.jpg", ratingFormatted: nil, averagePrice: nil),
        Item(type: .property, id: "1234567894", askingPrice: 12490000, monthlyFee: 5100, municipality: "Göteborgs kommun", area: "Vasastaden", daysSincePublish: 1, livingArea: 250, numberOfRooms: 7, streetAddress: "Mockvägen 5", image: "https://upload.wikimedia.org/wikipedia/commons/f/f9/Navigat%C3%B8rernes_Hus_01.jpg", ratingFormatted: nil, averagePrice: nil),
        Item(type: .property, id: "1234567895", askingPrice: 4100000, monthlyFee: 4100, municipality: "Falu kommun", area: "Källviken", daysSincePublish: 4, livingArea: 163, numberOfRooms: 5, streetAddress: "Mockvägen 6", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Braskens_hus_20160717.jpg/800px-Braskens_hus_20160717.jpg", ratingFormatted: nil, averagePrice: nil)
    ]
}
