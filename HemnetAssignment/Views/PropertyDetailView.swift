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
            Rectangle()
                .frame(height: 550)
                .foregroundStyle(.white)
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
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .ignoresSafeArea()
                }
                
            
            BottomCardView(item: item)
        }
        .ignoresSafeArea()
    }
}


fileprivate struct BottomCardView: View {
    let item: Item
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(Color("MainBackgroundTint"))
                    .frame(width: 400, height: UIScreen.main.bounds.height / 2.5)
                    .overlay(
                        VStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 8) {
                                if let municipality = item.municipality {
                                    HStack {
                                        Text(municipality)
                                            .font(.custom("Epilogue-Bold", size: 16))
                                            .foregroundStyle(.gray)
                                    }
                                }
                                
                                if let address = item.streetAddress {
                                    Text(address)
                                        .font(.custom("Epilogue-Bold", size: 26))
                                }
                                
                                Text(item.area)
                                    .font(.custom("Epilogue-Bold", size: 20))
                                
                                Spacer()
                                    .frame(height: 20)
                                
                                if let rooms = item.numberOfRooms {
                                    Text("\(rooms) rum")
                                }
                                
                                if let askingPrice = item.askingPrice {
                                    HStack {
                                        Image(systemName: "dollarsign.square")
                                        Text("\(askingPrice) sek")
                                    }
                                }
                                
                                HStack(spacing: 18) {
                                    if let rooms = item.numberOfRooms {
                                        HStack {
                                            Image(systemName: "bed.double")
                                            if rooms > 1 {
                                                Text("\(rooms - 1)")
                                            } else {
                                                Text("\(rooms)")
                                            }
                                        }
                                    }
                                    
                                    if let monthly = item.monthlyFee {
                                        HStack {
                                            Image(systemName: "calendar.circle")
                                            Text("\(monthly) sek")
                                        }
                                    }
                                    
                                    if let livingArea = item.livingArea {
                                        HStack {
                                            Image(systemName: "square.resize")
                                            Text("\(livingArea) kvm")
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                            .frame(width: 350, alignment: .leading)
                            .padding(.top, 24)
                            
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                                .frame(width: 250, height: 50)
                                .overlay {
                                    Text("Anmäl till visning")
                                        .font(.custom("Epilogue-Medium", size: 16))
                                }
                                .padding(.bottom, 36)
                        }
                    )
            }
        }
    }
}


#Preview {
    PropertyDetailView(item: Item.mockData[0])
}
