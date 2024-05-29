//
//  Home.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-24.
//

import Foundation
import SwiftUI


struct Home: View {
    @EnvironmentObject var viewModel : PropertyViewModel
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color("MainBackgroundTint").opacity(0.3)
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text("Raketen")
                            .font(.custom("Epilogue-Bold", size: 28))
                            .padding()
                            .bold()
                            .multilineTextAlignment(.center)
                            .zIndex(1.0)
                        
                        ForEach(viewModel.highlightedProperties) { item in
                            NavigationLink(destination: PropertyDetailView(item: item)) {
                                
                                HighlightedPropertyRow(item: item)
                                    .padding(.bottom, 16)
                            }
                        }.background {
                            
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color("MainBackgroundTint").opacity(0.0))
                                .frame(width: 400, height: 430)
                                .offset(y: -70)
                        }
                        
                        Spacer()
                            .frame(height: 30)
                        
                        ForEach(viewModel.properties) { item in
                            NavigationLink(destination: PropertyDetailView(item: item)) {
                                if item.type == .highlightedProperty {
                                    HighlightedPropertyRow(item: item)
                                    
                                } else if item.type == .property {
                                    PropertyRow(item: item)

                                } else if item.type == .area {
                                    AreaRow(item: item)
                                        .padding(.bottom, 16)
                                }
                                
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .background(Color.black
                    .opacity(0.03)
                    .shadow(color: .black, radius: 1, x: 0, y: 4)
                    .blur(radius: 15, opaque: false)
                )
                .scrollIndicators(.hidden)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchNewProperties()
        }
    }
}

#Preview {
    Home()
        .environmentObject(PropertyViewModel())
}


