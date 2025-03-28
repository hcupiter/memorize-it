//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

import SwiftUI

struct PackedItemDataView: View {
    let prompt: String? = nil
    let selectedPackedItem: PackedItem
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                if let prompt = prompt {
                    Text(prompt)
                        .fontWeight(.bold)
                        .font(.title3)
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selectedPackedItem.stocks.sorted(by: {
                            $0.item.id < $1.item.id
                        }), id: \.id) { stock in
                            VStack {
                                ItemCardView(stock: stock)
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
        .background(Color(uiColor: .secondarySystemFill), in: PackedItemDataViewBackgroundShape())
    }
}

struct PackedItemDataViewBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: 8)
            .path(in: rect)
//            .subtracting(
//                RoundedRectangle(cornerRadius: 8)
//                    .path(in: rect.insetBy(dx: 20, dy: 5))
//            )
    }
}

