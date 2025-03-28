//
//  Sheet.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 31/01/25.
//

enum Sheet {
    case deliver(
        packedItem: PackedItem,
        customerList: AnyCustomerList,
        finishedPackedItemList: FinishedPackedItemListViewModel,
        gameState: GameState,
        statistics: AnyGameStatistics,
        onDismiss: () -> ()
    )
    
    case viewPackItemDetail(
        packedItem: PackedItem,
        finishedItemList: FinishedPackedItemListViewModel,
        stockList: StockListViewModel,
        onDismiss: () -> ()
    )
    
    case scoreDetail(
        score: Score
    )
    
    case exitConfirmation(
        gameState: GameState
    )
}

extension Sheet: Identifiable {
    var id: Self { return self }
}

extension Sheet: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension Sheet: Equatable {
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        switch (lhs, rhs) {
        case (.deliver, .deliver),
            (.exitConfirmation, .exitConfirmation),
            (.scoreDetail, .scoreDetail),
            (.viewPackItemDetail, .viewPackItemDetail):
            return true
        default:
            return false
        }
    }
}
