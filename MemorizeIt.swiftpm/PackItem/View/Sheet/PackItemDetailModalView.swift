//
//  PackItemDetailModalView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 11/02/25.
//

import SwiftUI

struct PackItemDetailModalView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var fontManager: FontManager
    
    @ObservedObject var finishedItemList: FinishedPackedItemListViewModel
    @ObservedObject var stockList: StockListViewModel
    
    let packedItem: PackedItem
    let onDismiss: () -> ()
    
    var body: some View {
        VStack {
            VStack {
                Text("Package Contents:")
                    .font(fontManager.getFont(.title2, .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                PackedItemDataView(
                    selectedPackedItem: packedItem
                )
            }
            Spacer()
            
            Button {
                SoundFXManager.playSound(soundFX: .itempacked)
                stockList.unpack(packedItem: packedItem)
                finishedItemList.unpackPackedItem(packedItem: packedItem, appCoordinator: coordinator)
            } label: {
                HStack {
                    Image(systemName: "arrow.up.bin.fill")
                    Text("Unpack Package")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .font(fontManager.getFont(.body, .bold))
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(Color.red)
            
        }
        .padding(16)
        .frame(maxHeight: .infinity, alignment: .top)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    finishedItemList.unsetPackedItem(appCoordinator: coordinator)
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.red)
                }
                
            }
        }
    }
}
