//
//  FinishedPackedItemView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import SwiftUI
import Subsonic

struct PackItemFinishedItemView: View {
    @EnvironmentObject private var fontManager: FontManager
    @EnvironmentObject private var coordinator: AppCoordinator
    
    @EnvironmentObject private var gameState: GameState
    @EnvironmentObject private var finishedItemList: FinishedPackedItemListViewModel
    
    @EnvironmentObject private var stockList: StockListViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Packaged Items")
                        .font(fontManager.getFont(.title3, .bold))
                    Text("Tap to view package content")
                        .font(fontManager.getFont())
                }
                
                if finishedItemList.finishedPackedItemList.isEmpty {
                    Text("Empty...")
                        .font(fontManager.getFont())
                        .padding(.horizontal, 16)
                        .background(Color(uiColor: .systemFill), in: PackedItemDataViewBackgroundShape()
                        )
                }
                else {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(
                                finishedItemList.displayedPackedItem,
                                id: \.id) { packedItem in
                                    FinishedPackedItemCardView(
                                        packed: packedItem,
                                        isSelected: isSelected(packedItem),
                                        onTap: {
                                            finishedItemList.setPackedItem(
                                                packedItem,
                                                appCoordinator: coordinator,
                                                stockList: stockList
                                            )
                                    })
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(uiColor: .systemFill).gradient, in: PackedItemDataViewBackgroundShape())
    }
    
    func isSelected(_ packed: PackedItem) -> Bool {
        if finishedItemList.selectedPackedItem?.id == packed.id {
            return true
        }
        return false
    }
}

struct PackItemFinishedItemBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: 6)
            .path(in: rect)
    }
}
