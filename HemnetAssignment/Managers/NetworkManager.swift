//
//  NetworkManager.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//
import Combine
import Foundation
import UIKit

enum API {
    static let baseURL = "https://pastebin.com/raw/"
    
    static func propertiesURL() -> URL? {
        return URL(string: "\(baseURL)nH5NinBi")
    }
    
    static let startScreenImageURL = URL(string: "https://images.unsplash.com/photo-1533417005-2839504859a1?q=80&w=2524&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
}

enum APILoadingState {
    case loading
    case success(UIImage)
    case failure(Error)
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case error(Error)
    case decodeError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private var cancellable: AnyCancellable?
    
    func fetchProperties(completion: @escaping (Result<[Item], NetworkError>) -> Void) {
        guard let url = API.propertiesURL() else {
            completion(.failure(.invalidURL))
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                return output.data
            }
            .decode(type: PropertyResponse.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if error is DecodingError {
                    return .decodeError
                } else {
                    return .error(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completionStatus in
                    switch completionStatus {
                    case .finished:
                        break
                    case .failure(let error):
                        completion(.failure(error))
                    }
                },
                receiveValue: { response in
                    completion(.success(response.items))
                }
            )
    }
}

extension NetworkManager {
    
    static let mockData: [Item] = [
        Item(type: .highlightedProperty, id: "1234567890", askingPrice: 2650000, monthlyFee: nil, municipality: "Gällivare kommun", area: "Heden", daysSincePublish: 1, livingArea: 120, numberOfRooms: 5, streetAddress: "Mockvägen 1", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg", ratingFormatted: nil, averagePrice: nil),
        Item(type: .property, id: "1234567891", askingPrice: 6950000, monthlyFee: 3498, municipality: "Stockholm", area: "Nedre Gärdet", daysSincePublish: 10, livingArea: 85, numberOfRooms: 3, streetAddress: "Mockvägen 2", image: "https://upload.wikimedia.org/wikipedia/commons/8/8f/Arkitekt_Peder_Magnussen_hus_H%C3%B8nefoss_HDR.jpg", ratingFormatted: nil, averagePrice: nil),
        Item(type: .area, id: "1234567892", askingPrice: nil, monthlyFee: nil, municipality: nil, area: "Stockholm", daysSincePublish: nil, livingArea: nil, numberOfRooms: nil, streetAddress: nil, image: "https://i.imgur.com/v6GDnCG.png", ratingFormatted: "4.5/5", averagePrice: 50100),
        Item(type: .property, id: "1234567893", askingPrice: 1150000, monthlyFee: 2298, municipality: "Uppsala kommun", area: "Kvarngärdet", daysSincePublish: 12, livingArea: 29, numberOfRooms: 1, streetAddress: "Mockvägen 4", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Bertha_Petterssons_hus_01.jpg/800px-Bertha_Petterssons_hus_01.jpg", ratingFormatted: nil, averagePrice: nil),
        Item(type: .property, id: "1234567894", askingPrice: 12490000, monthlyFee: 5100, municipality: "Göteborgs kommun", area: "Vasastaden", daysSincePublish: 1, livingArea: 250, numberOfRooms: 7, streetAddress: "Mockvägen 5", image: "https://upload.wikimedia.org/wikipedia/commons/f/f9/Navigat%C3%B8rernes_Hus_01.jpg", ratingFormatted: nil, averagePrice: nil),
        Item(type: .property, id: "1234567895", askingPrice: 4100000, monthlyFee: 4100, municipality: "Falu kommun", area: "Källviken", daysSincePublish: 4, livingArea: 163, numberOfRooms: 5, streetAddress: "Mockvägen 6", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Braskens_hus_20160717.jpg/800px-Braskens_hus_20160717.jpg", ratingFormatted: nil, averagePrice: nil)
    ]
}
