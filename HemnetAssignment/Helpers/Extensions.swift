//
//  Extensions.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-28.
//

import Foundation
import SwiftUI

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

