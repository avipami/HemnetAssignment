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

extension View {
    func testView(width: CGFloat? = nil, height: CGFloat? = nil, colorScheme: ColorScheme? = nil) -> UIView {
        let viewController = UIHostingController(rootView: self.environment(\.colorScheme, colorScheme ?? .light))
        viewController._disableSafeArea = true
        
        let calculatedSize = width.map {
            viewController.view.sizeThatFits(
                CGSize(width: $0, height: height ?? CGFloat.greatestFiniteMagnitude))
        } ?? UIScreen.main.bounds.size
        
        let window = UIWindow(frame: CGRect(origin: .zero, size: calculatedSize))
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        window.backgroundColor = colorScheme == .light ? .white : .black
        return viewController.view
    }
}

