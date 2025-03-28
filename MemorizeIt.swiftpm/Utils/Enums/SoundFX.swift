//
//  SoundFX.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 21/02/25.
//

enum SoundFX {
    case bubblepop
    case gamecompleted
    case itempacked
    case ordercompleted
    case purchasesuccessfull
    case uiclick
    case walking
    case whip
    
    var value: String {
        switch self {
        case .bubblepop:
            return "bubble-pop"
        case .gamecompleted:
            return "game-completed"
        case .itempacked:
            return "item-packed"
        case .ordercompleted:
            return "order-completed"
        case .purchasesuccessfull:
            return "purchase-successfull"
        case .uiclick:
            return "ui-click"
        case .walking:
            return "walking"
        case .whip:
            return "whip"
        }
    }
    
    var volume: Float {
        return 0.5
    }
}
