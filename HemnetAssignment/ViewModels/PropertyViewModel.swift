//
//  PropertyViewModel.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-27.
//

import Foundation

class PropertyViewModel: ObservableObject {
    @Published var state: APILoadingState = .idle
    @Published var properties: [Item] = []
    @Published var highlightedProperties: [Item] = []
    @Published var areas: [Item] = []
    @Published var refreshData: Bool = true
    
    var networkManager: NetworkManaging
    
    
    init(_ networkManager : NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchNewProperties() {
        guard refreshData == true else { return }
        print("Fetching Properties")
        networkManager.fetchProperties() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let properties):
                    properties.forEach { property in
                        switch property.type {
                        case .area:
                            self.areas.append(property)
                            
                        case .highlightedProperty:
                            self.highlightedProperties.append(property)
                        case .property:
                            self.properties.append(property)
                        }
                        self.state = .success()
                    }
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
        refreshData = false
    }
}
