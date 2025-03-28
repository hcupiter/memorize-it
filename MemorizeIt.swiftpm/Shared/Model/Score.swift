//
//  Score.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/02/25.
//

import Foundation

struct Score: Sendable {
    var id: UUID
    var date: Date
    var value: Int {
        let customerSatisifed: Int = 100 * customerSatisified
        return customerSatisifed + (self.moneyEarned * 10)
    }
    
    // details
    var customerSatisified: Int
    var moneyEarned: Int
    var moneyUsed: Int
    var viewSwitchingTimes: Int
    var timeWasted: Int {
        viewSwitchingTimes * Constant.timeSwitchView
    }
    
    var toDisplayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    var toDisplayDateTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}

extension Score {
    func mapToDTO() -> ScoreSchema {
        return .init(
            id: self.id,
            date: self.date,
            customerSatisified: self.customerSatisified,
            moneyEarned: self.moneyEarned,
            moneyUsed: self.moneyUsed,
            viewSwitchingTimes: self.viewSwitchingTimes
        )
    }
}

extension Score {
    static func mock() -> [Score] {
        return [
            .init(
                id: UUID(),
                date: Date.now,
                customerSatisified: 10,
                moneyEarned: 5000,
                moneyUsed: 3000,
                viewSwitchingTimes: 20
            ),
            .init(
                id: UUID(),
                date: Date.now.addingTimeInterval(10 * 60 * 60),
                customerSatisified: 20,
                moneyEarned: 9000,
                moneyUsed: 8000,
                viewSwitchingTimes: 5
            )
        ]
    }
}
