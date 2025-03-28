//
//  BalanceUpdateable.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

protocol BalanceUpdatable {
    func updateBalance(event: BalanceChangedEvent)
}
