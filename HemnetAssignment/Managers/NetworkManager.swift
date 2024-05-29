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
    
    static let startScreenImageURL =  "https://images.unsplash.com/photo-1533417005-2839504859a1?q=80&w=2524&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
}

enum APIImageState {
    case idle
    case loading
    case success(UIImage? = nil)
    case failure(Error)
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case error(Error)
    case decodeError
}

protocol NetworkManaging {
    func fetchProperties(completion: @escaping (Result<[Item], NetworkError>) -> Void)
}

class NetworkManager: NetworkManaging {
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

// Mock NetworkManager for testing
class MockNetworkManager: NetworkManaging {
    var result: Result<[Item], NetworkError> = .success([])
    
    var fetchPropertiesInvokeCount = 0
    
    func fetchProperties(completion: @escaping (Result<[Item], NetworkError>) -> Void) {
        fetchPropertiesInvokeCount += 1
        completion(result)
    }
}
