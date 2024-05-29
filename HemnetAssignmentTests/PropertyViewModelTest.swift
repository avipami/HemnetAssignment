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
                    
                    expect(viewModel.state).toEventually(beAKindOf(APIImageState.self))
                    expect(viewModel.properties).toEventuallyNot(beNil())
                    expect(mockNetworkManager.fetchPropertiesInvokeCount).to(equal(1))
                }
                
                it("should set error state on failure") {
                    
                    mockNetworkManager.result = .failure(.invalidResponse)
                    
                    viewModel.fetchNewProperties()
                    
                    expect(viewModel.state).toEventually(beAKindOf(APIImageState.self))
                    expect(viewModel.state).toEventuallyNot(beNil())
                    expect(mockNetworkManager.fetchPropertiesInvokeCount).to(equal(1))
                }
            }
        }
    }
}
