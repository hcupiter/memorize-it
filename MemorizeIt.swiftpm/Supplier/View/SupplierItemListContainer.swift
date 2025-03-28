//
//  StorageItemListContainer.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import SwiftUI

struct SupplierItemListContainer: View {
    @EnvironmentObject var fontManager: FontManager
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var viewModel: AvailableItemViewModel
    
    // Define a flexible grid item
    let columns = Array(repeating: GridItem(.flexible()), count: 5)
    
    var body: some View {
        VStack (){
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Store Item List")
                        .font(fontManager.getFont(.title2, .bold))
                    Text("Tap item to add into cart")
                        .font(fontManager.getFont())
                }
                
                VStack {
                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .trailing) {
                            ForEach(viewModel.availableItem, id: \.id) { item in
                                Button {
                                    SoundFXManager.playSound(soundFX: .bubblepop)
                                    viewModel.handleTap(
                                        event: .add(item: item, quantity: 1)
                                    )
                                } label: {
                                    CatalogItemCardView(
                                        item: item
                                    )
                                }
                                .foregroundStyle(Color.black)
                            }
                        }
                        .scrollBounceBehavior(.basedOnSize)
                    }
                }
            }
            .padding(16)
        }
        .background(
            Color.fromHex("#D8AA97").gradient,
            in: SupplierItemListContainerBackgroundShape()
        )
        
    }
}

struct SupplierItemListContainerBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: 10)
            .path(in: rect)
    }
}
