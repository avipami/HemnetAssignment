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
            var sut: UIView!
            
            beforeEach {
                sut = PropertyDetailView(item: Item.mockData[0]).testView()
            }
            
            it("should have a valid snapshot for highlighted property") {
                expect(sut).toEventually(haveValidSnapshot(named: "DetailViewSnap"), timeout: .seconds(1))
                
            }
        }
    }
}

