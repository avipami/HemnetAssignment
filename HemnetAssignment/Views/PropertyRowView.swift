//
//  PropertyRowView.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-28.
//

import SwiftUI

struct PropertyRow: View {
    let item: Item
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.white)
            .overlay(
                HStack {
                    AsyncImage(url: URL(string: item.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    .frame(width: 120, height: 120)
                    .cornerRadius(8)
                    Spacer()
                        .frame(width: 40
                        )
                    VStack(alignment: .leading) {
                        Text(item.area)
                            .font(.custom("Epilogue-Bold", size: 16))
                            .kerning(0.8)
                            .foregroundStyle(.black)
                            .lineLimit(1)
                        Spacer()
                            .frame(height: 25)
                        if let price = item.askingPrice {
                            Text("Pris: \(price) SEK")
                                .font(.custom("Epilogue-Medium", size: 16))
                                .lineLimit(1)
                        }
                        if let rooms = item.numberOfRooms {
                            Text("\(rooms) rum, \(item.livingArea ?? 0) kvm")
                                .font(.custom("Epilogue-Medium", size: 16))
                                .foregroundStyle(.black)
                                .lineLimit(1)
                        }
                    }
                    .padding(.trailing, 16)
                }
            )
            .frame(width: 350, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
        
        
    }
}

#Preview {
    PropertyRow(item: Item.mockData[1])
}
