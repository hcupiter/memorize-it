//
//  Supplyable.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

protocol ItemStorable {
    func updateItemStock(event: ItemChangedEvent)
}
