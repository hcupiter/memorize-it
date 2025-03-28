//
//  CounterActionContainer.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

import SwiftUI

struct CounterActionContainer: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var fontManager: FontManager
    @EnvironmentObject var statistics: AnyGameStatistics
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button {
                    SoundFXManager.playSound(soundFX: .walking)
                    gameState.switchView(to: .store, statistics: statistics)
                } label: {
                    HStack(spacing: 24) {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                        Text("Go to Supplier")
                            .font(fontManager.getFont(.title3, .bold))
                            .foregroundStyle(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color.blue)
                
                Button {
                    SoundFXManager.playSound(soundFX: .walking)
                    gameState.switchView(to: .pack, statistics: statistics)
                } label: {
                    HStack(spacing: 24) {
                        Text("Go to Storage")
                            .font(fontManager.getFont(.title3, .bold))
                            .foregroundStyle(Color.white)
                        Image(systemName: "chevron.forward")
                            .imageScale(.large)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color.brown)
            }
            
            Button {
                SoundFXManager.playSound(soundFX: .uiclick)
                gameState.pauseGame(coordinator: coordinator)
            } label: {
                HStack(spacing: 24) {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                    Text("Exit Game")
                        .font(fontManager.getFont(.title3, .bold))
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(Color.red)
        }
//        .frame(maxHeight: .infinity)
    }
}

