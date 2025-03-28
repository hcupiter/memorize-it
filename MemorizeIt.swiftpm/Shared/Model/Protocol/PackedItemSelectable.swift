//
//  PackedItemSelectable.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

protocol PackedItemSelectable {
    func set(
        packedItem: PackedItem,
        coordinator: AppCoordinatorProtocol,
        updatePackedItemFrom: FinishedPackedItemListViewModel,
        addBalanceTo: GameState,
        statistics: AnyGameStatistics
    )
}
