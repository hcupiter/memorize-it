//
//  ScoreSchema.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 21/02/25.
//

import SwiftData
import Foundation

@Model
final class ScoreSchema {
    var scoreID: UUID?
    var date: Date?
    var customerSatisified: Int?
    var moneyEarned: Int?
    var moneyUsed: Int?
    var viewSwitchingTimes: Int?
    
    init(id: UUID, date: Date, customerSatisified: Int, moneyEarned: Int, moneyUsed: Int, viewSwitchingTimes: Int) {
        self.scoreID = id
        self.date = date
        self.customerSatisified = customerSatisified
        self.moneyEarned = moneyEarned
        self.moneyUsed = moneyUsed
        self.viewSwitchingTimes = viewSwitchingTimes
    }
}

extension ScoreSchema {
    func mapToEntity() -> Score {
        return .init(
            id: scoreID ?? UUID(),
            date: date ?? Date.now,
            customerSatisified: customerSatisified ?? 0,
            moneyEarned: moneyEarned ?? 0,
            moneyUsed: moneyUsed ?? 0,
            viewSwitchingTimes: viewSwitchingTimes ?? 0
        )
    }
}
