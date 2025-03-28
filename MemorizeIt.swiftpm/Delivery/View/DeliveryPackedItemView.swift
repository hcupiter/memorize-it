//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 31/01/25.
//

import SwiftUI

struct DeliveryPackedItemView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var fontManager: FontManager
    
    @ObservedObject var customerList: AnyCustomerList
    @ObservedObject var finishedPackedItemList: FinishedPackedItemListViewModel
    @ObservedObject var gameState: GameState
    @ObservedObject var statistics: AnyGameStatistics
    
    @StateObject private var itemDelivery: ItemDeliveryViewModel
    let onDismiss: () -> ()
    
    init(
        packedItem: PackedItem,
        customerList: AnyCustomerList,
        finishedPackedItemList: FinishedPackedItemListViewModel,
        gameState: GameState,
        statistics: AnyGameStatistics,
        onDismiss: @escaping () -> ()
    ) {
        self._itemDelivery = .init(
            wrappedValue: .init(selectedItem: packedItem)
        )
        self.customerList = customerList
        self.onDismiss = onDismiss
        self.finishedPackedItemList = finishedPackedItemList
        self.gameState = gameState
        self.statistics = statistics
    }
    
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Text("Package Contents:")
                    .font(fontManager.getFont(.title2, .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                PackedItemDataView(
                    selectedPackedItem: itemDelivery.selectedItem
                )
            }
            
            VStack {
                Text("Select Customer")
                    .font(fontManager.getFont(.title3, .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                DeliveryPackedItemSelectCustomerView(customerList: customerList)
            }
            
            Spacer()
            
            VStack {
                if let errorMessage = customerList.errorMessage {
                    Text("\(errorMessage)")
                        .font(fontManager.getFont())
                        .foregroundStyle(.red)
                }
                if let customer = customerList.selectedCustomer {
                    Button {
                        customerList.sellPackedItem(
                            customer: customer,
                            appCoordinator: coordinator,
                            updatePackedItemFrom: finishedPackedItemList,
                            addBalanceTo: gameState,
                            statistics: statistics
                        )
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                            Text("Sell Items to \(customer.name)")
                                .font(fontManager.getFont(.body, .bold))
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(Color.blue)

                }
            }
        }
        .padding(16)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onDismiss()
                    coordinator.dismissSheet()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundStyle(Color(uiColor: .red))
                }
            }
        })
    }
    
    
    
}
