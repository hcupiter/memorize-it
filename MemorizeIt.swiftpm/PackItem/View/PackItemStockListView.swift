//
//  StockListPanel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import SwiftUI

struct PackItemStockListView: View {
    @EnvironmentObject private var fontManager: FontManager
    @EnvironmentObject private var gameState: GameState
    
    @EnvironmentObject private var stockList: StockListViewModel
    @EnvironmentObject private var tableItemList: TableItemViewModel
    
    let columns = Array(repeating: GridItem(.flexible()), count: 5)
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Inventory")
                        .font(fontManager.getFont(.title3, .bold))
                    Text("Your stock (Tap to put to the table)")
                        .font(fontManager.getFont())
                }
                
                if stockList.stockList.isEmpty {
                    Text("Empty...")
                        .font(fontManager.getFont())
                        .padding(.horizontal, 16)
                        .background(Color(uiColor: .systemFill), in: PackedItemDataViewBackgroundShape()
                        )
                }
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(
                            Array(stockList.stockList.values)
                                .sorted(by: { $0.item.id < $1.item.id}),
                            id: \.id
                        ) { stock in
                            Button {
                                SoundFXManager.playSound(soundFX: .bubblepop)
                                tableItemList.handleTap(
                                    event: .add(item: stock.item, quantity: 1),
                                    onComplete: stockList
                                )
                            } label: {
                                StockItemCardView(stock: stock)
                            }
                            .foregroundStyle(Color.black)

                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.fromHex("#D8AA97").gradient, in: PackItemStockListBackgroundShape())
    }
}

struct PackItemStockListBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: 6)
            .path(in: rect)
    }
}
