//
//  Screen.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 31/01/25.
//

enum Screen {
    case mainMenu
    case game
    case debug
    case highScore
    case credit
    case tutorial
}

extension Screen: Identifiable {
    var id: Self { return self }
}

extension Screen: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension Screen: Equatable {
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        case (.mainMenu, .mainMenu),
            (.debug, .debug),
            (.game, .game),
            (.credit, .credit),
            (.tutorial, .tutorial),
            (.highScore, .highScore):
            return true
        default:
            return false
        }
    }
}
