//
//  AreaRowView.swift
//  HemnetAssignment
//
//  Created by Vincent Palma on 2024-05-28.
//

import SwiftUI

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
