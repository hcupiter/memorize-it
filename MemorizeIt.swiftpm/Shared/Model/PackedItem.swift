//
//  PackedItem.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import Foundation

struct PackedItem {
    var id: UUID
    var dateCreated: Date
    var stocks: [Stock]
}

extension PackedItem {
    static var mock: [PackedItem] {
        [
            .init(
                id: UUID(),
                dateCreated: .now.addingTimeInterval(-10),
                stocks: Stock.mock()
            )
        ]
    }
}
