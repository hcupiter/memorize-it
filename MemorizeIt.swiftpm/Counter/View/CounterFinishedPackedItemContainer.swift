//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

import SwiftUI

struct CounterFinishedPackedItemContainer: View {
    @EnvironmentObject var finishedItem: FinishedPackedItemListViewModel
    @EnvironmentObject var customerList: AnyCustomerList
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var statistics: AnyGameStatistics
    
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var fontManager: FontManager
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Packed Items")
                        .font(fontManager.getFont(.title3, .bold))
                    Text("Select a finished packed item and sell it to a customer")
                        .font(fontManager.getFont(.body, .sans))
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        if finishedItem.displayedPackedItem.isEmpty {
                            Text("Empty...")
                                .font(fontManager.getFont())
                                .padding(.horizontal, 16)
                                .background(Color(uiColor: .systemFill), in: LabelBackgroundShape()
                                )
                        }
                        ForEach(finishedItem.displayedPackedItem, id: \.id) { packed in
                            FinishedPackedItemCardView(
                                packed: packed,
                                isSelected: isSelected(packedItem: packed),
                                onTap: {
                                    customerList.set(
                                        packedItem: packed,
                                        coordinator: coordinator,
                                        updatePackedItemFrom: finishedItem,
                                        addBalanceTo: gameState,
                                        statistics: statistics
                                    )
                                }
                            )
                        }
                    }
                }
            }
            .padding()
            .frame(height: 200, alignment: .top)
        }
        .background(Color(uiColor: .secondarySystemFill).gradient, in: CounterFinishedPackedItemContainerBackgroundShape()
        )
    }
    
    func isSelected(packedItem: PackedItem) -> Bool {
        if customerList.selectedPackedItem?.id == packedItem.id {
            return true
        }
        return false
    }
}

struct CounterFinishedPackedItemContainerBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: 10)
            .path(in: rect)
    }
}

