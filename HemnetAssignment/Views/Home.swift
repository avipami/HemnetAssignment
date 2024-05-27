//
//  Home.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-24.
//

import Foundation
import SwiftUI

struct Home: View {
    @State var path = [Int]()
    @StateObject private var viewModel = PropertyViewModel()
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color("StartBackground").opacity(0.3)
                    .ignoresSafeArea()
                VStack {
                    Text("HYGGEBO")
                        .font(.system(size: 38))
                        .padding()
                        .bold()
                        .multilineTextAlignment(.center)
                        
                    ScrollView {
                        
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
                
                    .scrollIndicators(.hidden)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
        .environmentObject(viewModel)
    }
}

#Preview {
    Home()
}

struct HighlightedPropertyRow: View {
    let item: Item
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(item.area)
                    .font(.headline)
                if let price = item.askingPrice {
                    Text("Pris: \(price) SEK")
                }
                if let rooms = item.numberOfRooms {
                    Text("\(rooms) rum, \(item.livingArea ?? 0) kvm")
                }
            }
        }
        .padding()
    }
}

struct PropertyRow: View {
    let item: Item
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.white)
            .overlay(
                VStack {
                    AsyncImage(url: URL(string: item.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    .frame(width: 300, height: 150)
                    .cornerRadius(8)
                    
                    VStack {
                        Text(item.area)
                            .font(.headline)
                            .foregroundStyle(.black)
                        if let price = item.askingPrice {
                            Text("Pris: \(price) SEK")
                        }
                        if let rooms = item.numberOfRooms {
                            Text("\(rooms) rum, \(item.livingArea ?? 0) kvm")
                                .foregroundStyle(.black)
                        }
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: 350, height: 260)
        
    }
}

struct AreaRow: View {
    let item: Item
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(item.area)
                    .font(.headline)
                Text("Rating: \(item.ratingFormatted ?? "")")
                Text("Genomsnittspris: \(item.averagePrice ?? 0) SEK/kvm")
            }
        }
    }
}




