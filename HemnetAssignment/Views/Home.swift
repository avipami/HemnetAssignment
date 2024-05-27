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
                    Text("Nästa Lya")
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


struct PropertyDetailView: View {
    @Environment(\.dismiss) var dismiss
    let item: Item
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(height: 550)
                .overlay {
                    
                    AsyncImage(url: URL(string: item.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .ignoresSafeArea()
                }
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
            
            
            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    //Background Shape
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color("StartBackground"))
                        .frame(height: UIScreen.main.bounds.height / 2.5)
                        .overlay (
                            //Text info
                            VStack(alignment: .center, spacing: 16) {
                                if let address = item.streetAddress {
                                    
                                    Text(address)
                                        .font(.largeTitle)
                                        .bold()
                                }
                                
                                Text(item.area)
                                    .font(.largeTitle)
                                    .bold()
                                
                                if let rooms = item.numberOfRooms {
                                 Text("\(rooms) rum")
                                }
                                
                            
                                HStack {
                                    Image(systemName: "dollarsign.square")
                                    if let askingPrice = item.askingPrice {
                                        Text("\(askingPrice) sek")
                                    }
                                }
                                HStack(spacing: 18) {
                                    
                                    HStack {
                                        Image(systemName: "bed.double")
                                        if let rooms = item.numberOfRooms {
                                            if rooms > 1 {
                                                Text("\(rooms - 1)")
                                            } else {
                                                Text("\(rooms)")
                                            }
                                        }
                                    }
                                    
                                    HStack {
                                        Image(systemName: "calendar.circle")
                                        if let monthly = item.monthlyFee {
                                            Text("\(monthly) sek")
                                        }
                                    }
                                    
                                    HStack {
                                        Image(systemName: "square.resize")
                                        
                                        if let livingArea = item.livingArea {
                                            Text("\(livingArea) kvm")
                                        }
                                    }
                                }
                                Spacer()
                                    
                            }
                                .padding(.top, 24)
                        )
                    
                }
            }
            
        }
//        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea()
            
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

enum APILoadingState {
    case loading
    case success(UIImage)
    case failure(Error)
}


struct CustomBackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                Text("Back")
                    .foregroundColor(.white)
            }
            .padding(8)
            .background(Color.blue)
            .cornerRadius(8)
        }
    }
}

struct PropertyResponse: Codable {
    let items: [Item]
}

enum ItemType: String, Codable {
    case highlightedProperty = "HighlightedProperty"
    case property = "Property"
    case area = "Area"
}

struct Item: Codable, Identifiable {
    let type: ItemType
    let id: String
    let askingPrice: Int?
    let monthlyFee: Int?
    let municipality: String?
    let area: String
    let daysSincePublish: Int?
    let livingArea: Int?
    let numberOfRooms: Int?
    let streetAddress: String?
    let image: String
    let ratingFormatted: String?
    let averagePrice: Int?
}

class PropertyViewModel: ObservableObject {
    @Published var state: APILoadingState = .loading
    @Published var properties: [Item] = []
    @Published var highlightedProperties: [Item] = []
    @Published var areas: [Item] = []
    
    init() {
        fetchNewProperties()
    }
    
    func fetchNewProperties() {
        NetworkManager.shared.fetchProperties() { [weak self] result in
            guard let self = self else { return } // Ensure self is still available
            DispatchQueue.main.async {
                switch result {
                case .success(let properties):
                    properties.forEach { property in
                        switch property.type {
                        case .area:
                            self.areas.append(property)
                            
                        case .highlightedProperty:
                            self.highlightedProperties.append(property)
                        case .property:
                            self.properties.append(property)
                        }
                    }
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
    }
}
