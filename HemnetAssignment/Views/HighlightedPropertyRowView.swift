//
//  HighlightedPropertyRowView.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-28.
//

import SwiftUI

struct HighlightedPropertyRow: View {
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
                    
                    .frame(width: 500, height: 250)
                    .cornerRadius(8)
                    .overlay(
                        VStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .overlay(
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
                                ).frame(width: 400, height: 100)
                        }
                    )
                    Spacer()
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: 350, height: 260)
    }
}
