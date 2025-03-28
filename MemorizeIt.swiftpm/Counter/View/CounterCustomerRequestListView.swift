//
//  CounterCustomerRequestListView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

import SwiftUI

struct CounterCustomerRequestListView: View {
    let scale: CGFloat = 3
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var customerList: AnyCustomerList
    @EnvironmentObject var finishedPackedItem: FinishedPackedItemListViewModel
    
    @EnvironmentObject var fontManager: FontManager
    
    var body: some View {
        GeometryReader { geometry in
            HStack() {
                // Left Pane
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Order List: ")
                                .font(fontManager.getFont(.title2, .bold))
                        }
                        
                        if customerList.customerList.isEmpty {
                            HStack {
                                EmptyView()
                                Spacer()
                            }
                            .frame(maxHeight: .infinity)
                        }
                        else {
                            ScrollView {
                                ForEach(
                                    customerList.getDisplayedCustomerData(),
                                    id: \.id
                                ) { customer in
                                    VStack(alignment: .leading) {
                                        CounterCustomerRequestCard(customer: customer)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(uiColor: .systemFill), lineWidth: 2)
                )
            }
        }
    }
}

