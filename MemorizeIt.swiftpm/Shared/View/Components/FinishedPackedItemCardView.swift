//
//  CounterFinishedPackageCart.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

import SwiftUI

struct FinishedPackedItemCardView: View {
    let packed: PackedItem
    let isSelected: Bool
    let onTap: () -> ()
    
    var body: some View {
        VStack {
            Image("packeditem-model-default-1")
                .padding()
        }
        .background(isSelected ? Color.yellow : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            SoundFXManager.playSound(soundFX: .itempacked)
            onTap()
        }
    }
}
