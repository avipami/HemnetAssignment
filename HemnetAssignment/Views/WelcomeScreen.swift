//
//  WelcomeScreen.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-25.
//

import SwiftUI

struct WelcomeScreen: View {
    @State private var isShowingNextView = false
    @State private var dragAmount = CGSize.zero
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("StartBackground")
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome")
                    
                        PullTabView()
                            .padding(.trailing, 20) // Add padding to prevent overlap with navigation bar
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .offset(dragAmount)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragAmount = value.translation
                                        if value.translation.width < -100 {
                                            self.isShowingNextView = true
                                        }
                                    }
                            )
                    
                }.navigationDestination(isPresented: $isShowingNextView) {
                    withAnimation {
                        Home()
                            .transition(.opacity)
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeScreen()
}

struct PullTabView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 50, height: 50)
            .foregroundColor(.gray)
    }
}
