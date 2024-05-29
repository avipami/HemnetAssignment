//
//  HemnetAssignmentApp.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-20.
//

import SwiftUI

@main
struct HemnetAssignmentApp: App {
    @StateObject var viewModel: PropertyViewModel = PropertyViewModel()
    var body: some Scene {
        WindowGroup {
            WelcomeScreen()
                .environmentObject(viewModel)
                .environment(\.colorScheme, .light)
        }
    }
}
