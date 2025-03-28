//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/02/25.
//

import SwiftUI

struct CounterGameExitConfirmationSheet: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var fontManager: FontManager
    
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack() {
            VStack(spacing: 24) {
                Image("exit-confirmation-icon")
                    .resizable()
                    .frame(width: 200, height: 200)
                VStack(spacing: 16) {
                    Text("Are you sure you want to exit?")
                        .font(fontManager.getFont(.title2, .bold))
                        .multilineTextAlignment(.center)
                    Text("Your progress will be lost!")
                        .font(fontManager.getFont(.title3))
                        .multilineTextAlignment(.center)
                }
                .frame(width: 400)
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                Button {
                    SoundFXManager.playSound(soundFX: .uiclick)
                    gameState.pauseGame(coordinator: coordinator)
                } label: {
                    Text("Continue")
                        .font(fontManager.getFont(.title3))
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color.blue)
                
                Button {
                    SoundFXManager.playSound(soundFX: .uiclick)
                    gameState.exitGame(coordinator: coordinator)
                } label: {
                    Text("Exit Game")
                        .font(fontManager.getFont(.title3))
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color.red)

            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}
