//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 25/01/25.
//

import SwiftUI

struct CounterCustomerRequestCard: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var customerList: AnyCustomerList
    @EnvironmentObject var packedItemList: FinishedPackedItemListViewModel
    
    @EnvironmentObject var fontManager: FontManager
    
    let customer: Customer
    
    var body: some View {
        VStack() {
            VStack {
                HStack {
                    Text("\(customer.name)")
                        .font(fontManager.getFont(.body, .bold))
                    Spacer()
                    
//                    Image(systemName: isOpen ? "chevron.down" : "chevron.forward")

                }
                
//                if isOpen {
//
//                }
                VStack(alignment: .leading, spacing: 12) {
                    ScrollView(.horizontal) {
                        HStack(spacing: 8) {
                            ForEach(customer.requestList.sorted(by: {
                                $0.item.id < $1.item.id
                            }), id: \.id) { request in
                                ItemCardView(stock: request)
                            }
                        }
                    }
                    HStack {
                        Button(role: .destructive) {
                            SoundFXManager.playSound(soundFX: .whip)
                            customerList.removeCustomer(customer.id)
                        } label: {
                            Text("Remove Order")
                                .font(fontManager.getFont())
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .secondarySystemFill).gradient)
        .clipShape(RoundedRectangle(cornerRadius: 8))
//        .onTapGesture {
//            SoundFXManager.playSound(soundFX: .uiclick)
//            isOpen.toggle()
//        }
    }
}


