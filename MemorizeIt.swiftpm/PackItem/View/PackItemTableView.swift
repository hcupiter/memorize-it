//
//  TableToPackView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import SwiftUI

struct PackItemTableView: View {
    @EnvironmentObject private var fontManager: FontManager
    
    @EnvironmentObject private var gameState: GameState
    @EnvironmentObject private var finishedItemList: FinishedPackedItemListViewModel
    @EnvironmentObject private var stockListParent: StockListViewModel
    
    @EnvironmentObject private var tableItemList: TableItemViewModel
   
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Table")
                        .font(fontManager.getFont(.title3, .bold))
                    Text("Put all item here to be packaged. (Tap each item to remove it)")
                        .font(fontManager.getFont())
                }
                
                if tableItemList.listPackedItem.isEmpty {
                    Text("Empty...")
                        .font(fontManager.getFont())
                        .padding(.horizontal, 16)
                        .background(Color(uiColor: .systemFill), in: PackedItemDataViewBackgroundShape()
                        )
                }
                else {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(
                                    tableItemList.toDisplayListPackedItem,
                                    id: \.id
                                ) { stock in
                                    Button {
                                        SoundFXManager.playSound(soundFX: .bubblepop)
                                        tableItemList.handleTap(
                                            event: .substract(item: stock.item, quantity: 1),
                                            onComplete: stockListParent
                                        )
                                    } label: {
                                        ItemCardView(stock: stock, tint: Color(uiColor: .systemFill))
                                            .foregroundStyle(Color.black)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            SoundFXManager.playSound(soundFX: .itempacked)
                            tableItemList.packItem(
                                sendPackEvent: finishedItemList
                            )
                        } label: {
                            HStack {
                                Image(systemName: "shippingbox.fill")
                                Text("Pack Items")
                                    .font(fontManager.getFont(.body, .bold))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        .tint(.blue)
                    }
                }
            }
            .padding(16)
            .frame(height: 325, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(uiColor: .systemGray), lineWidth: 0.5)
        }
    }
}
