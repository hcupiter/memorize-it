//
//  StorageCartContainer.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import SwiftUI

struct SupplierCartContainer: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var fontManager: FontManager
    
    @EnvironmentObject private var gameState: GameState
    @EnvironmentObject private var viewModel: AvailableItemViewModel
    @EnvironmentObject private var stockList: StockListViewModel
    @EnvironmentObject private var statistics: AnyGameStatistics
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Cart")
                        .font(fontManager.getFont(.title2, .bold))
                    Text("Tap item to remove from cart")
                        .font(fontManager.getFont())
                }
                
                VStack {
                    if viewModel.cartItem.isEmpty {
                        Text("Empty...")
                            .font(fontManager.getFont())
                            .padding(.horizontal, 16)
                            .background(
                                Color(uiColor: .systemFill), in: LabelBackgroundShape()
                            )
                    }
                    else {
                        VStack {
                            ScrollView(.horizontal) {
                                HStack() {
                                    ForEach(
                                        viewModel.toDisplayCartItem,
                                        id: \.id
                                    ) { stock in
                                        Button {
                                            SoundFXManager.playSound(soundFX: .bubblepop)
                                            viewModel.handleTap(
                                                event: .substract(
                                                    item: stock.item,
                                                    quantity: 1
                                                )
                                            )
                                        } label: {
                                            ItemCardView(
                                                stock: stock,
                                                tint: Color(uiColor: .systemFill)
                                            )
                                        }
                                        .foregroundStyle(Color.black)
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            VStack (alignment: .leading){
                                HStack {
                                    Text("Total Price: ")
                                    Text("$\(viewModel.totalCartPrice)")
                                        .font(fontManager.getFont(.body, .bold))
                                        .foregroundStyle(Color.blue)
                                }
                                .font(fontManager.getFont(.body))
                                
                                Button {
                                    SoundFXManager.playSound(soundFX: .purchasesuccessfull)
                                    viewModel.checkout(
                                        coordinator: coordinator,
                                        balance: gameState.totalCoin,
                                        storage: stockList,
                                        purchase: gameState,
                                        statistics: statistics
                                    )
                                } label: {
                                    HStack {
                                        Image(systemName: "cart")
                                        Text("Checkout")
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
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(uiColor: .gray), lineWidth: 0.5)
        }
    }
}


