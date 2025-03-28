//
//  Overlay.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/02/25.
//

import Foundation

enum FullScreenCover {
    case endScreen(statistics: AnyGameStatistics, gameState: GameState)
}

extension FullScreenCover: Identifiable {
    var id: Self { return self }
}

extension FullScreenCover: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension FullScreenCover: Equatable {
    static func == (lhs: FullScreenCover, rhs: FullScreenCover) -> Bool {
        switch (lhs, rhs){
        case (.endScreen, .endScreen):
            return true
        }
    }
}
