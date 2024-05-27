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
                VStack {
                    Text("Hitta ditt\nnya hem")
                        .font(.system(size: 28))
                        .multilineTextAlignment(.center)
                    Text("HYGGEBO")
                        .font(.system(size: 38))
                        .padding()
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    PullTabView()
                        .padding(.trailing, -1)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .offset(x: dragAmount.width)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragAmount = value.translation
                                    if value.translation.width < -200 {
                                        self.isShowingNextView = true
                                    }
                                }
                        )
                }
                .padding(.vertical, 32)
                .padding(.top, 100)
                .navigationDestination(isPresented: $isShowingNextView) {
                    withAnimation {
                        Home()
                            .transition(.opacity)
                    }
                }
                
                
            }
            .background {
                AsyncImage(url: API.startScreenImageURL)
                { image in
                    image.image?.resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
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
            .frame(width: 80, height: 50)
            .foregroundColor(.white)
            .overlay {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundStyle(.black)
                    .bold()
            }
    }
}
