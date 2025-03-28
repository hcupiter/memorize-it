//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

import SwiftUI

struct FinishedPackedItemListView: View {
    let prompt: String?
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
                        ForEach(selectedPackedItem.stocks, id: \.id) { stock in
                            VStack {
                                ItemCardView(stock: stock, tint: Color.white)
                            }
                            .background(Color.white)
                        }
                    }
                }
            }
            .padding(16)
        }
        .background(Color(uiColor: .secondarySystemFill))
    }
}

