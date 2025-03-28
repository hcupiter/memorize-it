//
//  StorageView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import SwiftUI

struct SupplierView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var fontManager: FontManager
    @EnvironmentObject var statistics: AnyGameStatistics
    
    @StateObject private var viewModel: AvailableItemViewModel = .init()
        
    var body: some View {
        GeometryReader { geometry in
            VStack() {                
                VStack(spacing: 16) {
                    SupplierCartContainer()
                        .frame(height: 350)
                    
                    SupplierItemListContainer()
                }
                
                Button {
                    SoundFXManager.playSound(soundFX: .walking)
                    gameState.switchView(to: .counter, statistics: statistics)
                } label: {
                    Text("Back to the counter")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(fontManager.getFont(.title3, .bold))
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.blue)

            }
            .onAppear() {
                viewModel.setup()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .environmentObject(viewModel)
        }
    }
}
