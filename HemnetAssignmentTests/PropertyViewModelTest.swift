//
//  PropertyViewModelTest.swift
//  HemnetAssignmentTests
//
//  Created by Vincent Palma on 2024-05-28.
//

import Foundation
import XCTest
import Nimble
import Quick
@testable import HemnetAssignment

class PropertyViewModelSpec: QuickSpec {
    override class func spec() {
        describe("PropertyViewModel") {
            var viewModel: PropertyViewModel!
            var mockNetworkManager: MockNetworkManager!
            
            beforeEach {
                viewModel = PropertyViewModel()
                mockNetworkManager = MockNetworkManager()
                viewModel.networkManager = mockNetworkManager
            }
            
            context("when fetching new properties") {
                it("should update properties on success") {
                    
                    let mockProperties: [Item] = Item.mockData
                    mockNetworkManager.result = .success(mockProperties)
                    
                    viewModel.fetchNewProperties()
                    
                    expect(viewModel.state).toEventually(beAKindOf(APILoadingState.self))
                    expect(viewModel.properties).toEventuallyNot(beNil())
                }
                
                it("should set error state on failure") {
                    
                    mockNetworkManager.result = .failure(NetworkError.invalidResponse)
                    
                    viewModel.fetchNewProperties()
                    
                    expect(viewModel.state).to((beAKindOf(APILoadingState.self)))
                }
            }
        }
    }
}

// Mock NetworkManager for testing
class MockNetworkManager: NetworkManaging {
    var result: Result<[Item], NetworkError> = .success([])
    
    func fetchProperties(completion: @escaping (Result<[Item], NetworkError>) -> Void) {
        completion(result)
    }
}
