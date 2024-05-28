//
//  Home.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-24.
//

import Foundation
import SwiftUI

protocol viewModeling {
    
}

struct Home: View {
    @ObservedObject var viewModel : PropertyViewModel
    
    init(viewModel: PropertyViewModel = PropertyViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color("StartBackground").opacity(0.3)
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text("HYGGEBO")
                            .font(.system(size: 38))
                            .padding()
                            .bold()
                            .multilineTextAlignment(.center)
                        
                            ForEach(viewModel.highlightedProperties) { item in
                                NavigationLink(destination: PropertyDetailView(item: item)) {
                                    
                                    HighlightedPropertyRow(item: item)
                                        .padding(.bottom, 16)
                                }
                            }
                        
                            ForEach(viewModel.properties) { item in
                                NavigationLink(destination: PropertyDetailView(item: item)) {
                                    if item.type == .highlightedProperty {
                                        
                                        HighlightedPropertyRow(item: item)
                                            .padding(.bottom, 16)
                                        
                                    } else if item.type == .property {
                                        PropertyRow(item: item)
                                            .padding(.bottom, 16)
                                        
                                    } else if item.type == .area {
                                        AreaRow(item: item)
                                            .padding(.bottom, 16)
                                    }
                                        
                                }.buttonStyle(PlainButtonStyle())
                            }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(viewModel)
    }
}

#Preview {
    Home(viewModel: PropertyViewModel())
}



