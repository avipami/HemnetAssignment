//
//  PropertyDetailViewSnapshotTests.swift
//  HemnetAssignmentTests
//
//  Created by Vincent Palma on 2024-05-28.
//
import XCTest
import SwiftUI
import Nimble
import Nimble_Snapshots
import Quick

@testable import HemnetAssignment

class PropertyDetailViewSnapshotSpec: QuickSpec {
    override class func spec() {
        describe("PropertyDetailView") {
            var view: UIView!
            
            beforeEach {
                let item = Item(
                    type: .highlightedProperty,
                    id: "1234567890",
                    askingPrice: 2650000,
                    monthlyFee: nil,
                    municipality: "Gällivare kommun",
                    area: "Heden",
                    daysSincePublish: 1,
                    livingArea: 120,
                    numberOfRooms: 5,
                    streetAddress: "Mockvägen 1",
                    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg",
                    ratingFormatted: nil,
                    averagePrice: nil
                )
                
                let swiftuiView = PropertyDetailView(item: Item.mockData[0])
                
                let hostingController = UIHostingController(rootView: swiftuiView).view
                
                view = hostingController
            }
            
            it("should have a valid snapshot for highlighted property") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    expect(view).to(recordSnapshot(named: "DetailViewSnap"))
                }
            }
        }
    }
}
