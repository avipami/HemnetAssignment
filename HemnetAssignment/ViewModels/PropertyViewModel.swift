//
//  PropertyViewModel.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-27.
//

import Foundation

class PropertyViewModel: ObservableObject {
    @Published var state: APILoadingState = .loading
    @Published var properties: [Item] = []
    @Published var highlightedProperties: [Item] = []
    @Published var areas: [Item] = []
    
    init() {
        fetchNewProperties()
    }
    
    func fetchNewProperties() {
        NetworkManager.shared.fetchProperties() { [weak self] result in
            guard let self = self else { return } // Ensure self is still available
            DispatchQueue.main.async {
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
                    }
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
    }
}
