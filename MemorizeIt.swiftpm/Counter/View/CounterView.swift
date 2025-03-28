//
//  MemorizeView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

import SwiftUI

struct CounterView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var customerList: AnyCustomerList
    @EnvironmentObject var finishedPackedList: FinishedPackedItemListViewModel
    
    @State private var modal: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {                    
                    // Middle Top Pane
                    CounterCustomerRequestListView()
    //                    .frame(maxHeight: geometry.size.height / 2.5)
                    
                    // Middle Bottom Pane
                    CounterFinishedPackedItemContainer()
                    
    //                // Middle center pane
    //                if let selectedPackedItem = customerList.selectedPackedItem {
    //                    CounterSelectedFinishedPackedItemView(selectedPackedItem: selectedPackedItem)
    //                }
                }

                // BottomPane
                CounterActionContainer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}

