//
//  PropertyDetailView.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-27.
//

import SwiftUI

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
                        .foregroundStyle(Color("MainBackgroundTint"))
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
    PropertyDetailView(item: Item.mockData[0])
}


