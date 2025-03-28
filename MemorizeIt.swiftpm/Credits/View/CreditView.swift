//
//  CreditView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 21/02/25.
//

import SwiftUI

struct CreditView: View {
    @EnvironmentObject var fontManager: FontManager
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("Credits")
                .font(fontManager.getFont(.title, .bold))
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Created by: ")
                        .font(fontManager.getFont(.title3, .bold))
                    Text("Hans Arthur Cupiterson")
                        .font(fontManager.getFont(.title5))
                }
                
                VStack(alignment: .leading) {
                    Text("Sound Player:")
                        .font(fontManager.getFont(.title3, .bold))
                    Text("Subsonic (https://github.com/twostraws/Subsonic)")
                        .font(fontManager.getFont(.title5))
                }
                
                VStack(alignment: .leading) {
                    Text("Audio")
                        .font(fontManager.getFont(.title3, .bold))
                    Text("- Monkeys Spinning Monkeys (Kevin MacLeod)")
                        .font(fontManager.getFont(.title5))
                    Text("- [PIXABAY] New Level by Universfield")
                        .font(fontManager.getFont(.title5))
                    Text("- [PIXABAY] purchase succesful ingame by RibhavAgrawal")
                        .font(fontManager.getFont(.title5))
                    Text("- [PIXABAY] Message by Universfield")
                        .font(fontManager.getFont(.title5))
                    Text("- [PIXABAY] Open New Level by Universfield")
                        .font(fontManager.getFont(.title5))
                    Text("- [PIXABAY] Bubble Pop #2 by Universfield")
                        .font(fontManager.getFont(.title5))
                    Text("- [PIXABAY] Whip #3 by Universfield")
                        .font(fontManager.getFont(.title5))
                    Text("- [PIXABAY] UI click by freesound_community")
                        .font(fontManager.getFont(.title5))
                }
                VStack(alignment: .leading) {
                    Text("Font")
                        .font(fontManager.getFont(.title3, .bold))
                    Text("- Pixeloid Mono Font")
                        .font(fontManager.getFont(.title5))
                    Text("- Pixeloid Sans Font")
                        .font(fontManager.getFont(.title5))
                    Text("- Pixeloid Bold Font")
                        .font(fontManager.getFont(.title5))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button {
                coordinator.pop()
            } label: {
                Text("Close")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(Color.white)
                    .font(fontManager.getFont(.title3))
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(Color.blue)

        }
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
    }
}
