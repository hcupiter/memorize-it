//
//  ItemChangedEvent.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

enum ItemChangedEvent {
    case add(item: Item, quantity: Int)
    case substract(item: Item, quantity: Int)
    
    var item: Item {
        switch self {
        case .add(let item, _):
            return item
        case .substract(let item, _):
            return item
        }
    }
}
