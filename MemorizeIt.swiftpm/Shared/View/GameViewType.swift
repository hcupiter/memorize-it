//
//  GameViewType.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/01/25.
//

import SwiftUI

enum GameViewType {
    case counter
    case store
    case pack
    
    var title: String {
        switch self {
        case .counter:
            return "Order"
        case .store:
            return "Supplier"
        case .pack:
            return "Storage"
        }
    }
    
    var color: Color {
        switch self {
        case .counter:
            return Color(uiColor: .red)
        case .store:
            return Color(uiColor: .blue)
        case .pack:
            return Color(uiColor: .brown)
        }
    }
}
