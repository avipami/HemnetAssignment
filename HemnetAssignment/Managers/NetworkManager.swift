//
//  NetworkManager.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//
import Combine  
import Foundation

enum API {
    static let baseURL = "https://pastebin.com/raw/"
    
    static func propertiesURL() -> URL? {
        return URL(string: "\(baseURL)nH5NinBi")
    }
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
