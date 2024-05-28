//
//  HomeViewTest.swift
//  HemnetAssignmentTests
//
//  Created by Vincent Palma on 2024-05-28.
//

import SwiftUI
import Nimble
import Nimble_Snapshots
import Quick

@testable import HemnetAssignment

class HomeSnapshotSpec: QuickSpec {
    override class func spec() {
        describe("Home") {
            var viewModel: PropertyViewModel!
            var mockNetworkManager: MockNetworkManager!
            var sut: UIView!
            
            beforeEach {
                viewModel = PropertyViewModel()
                mockNetworkManager = MockNetworkManager()
                viewModel.networkManager = mockNetworkManager
                mockNetworkManager.result = .success(Item.mockData)
                
                sut = Home(viewModel: viewModel).testView()
                viewModel.fetchNewProperties()
            }
            
            it("should have a valid snapshot for the Home view") {
                
                expect(sut).toEventually(recordSnapshot(named: "HomeView"), timeout: .seconds(1))
            }
        }
    }
}
