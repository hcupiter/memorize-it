//
//  GameStatistics.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/02/25.
//

import Foundation
import SwiftData

class GameStatistics: GameStatisticsProtocol {
    var id: UUID
    var date: Date
    
    // details
    @Published var customerSatisified: Int = 0
    @Published var moneyEarned: Int = 0
    @Published var moneyUsed: Int = 0
    @Published var viewSwitchingTimes: Int = 0
    
    @Published var score: Score? 
    
    init() {
        self.id = UUID()
        self.date = Date.now
    }
    
    func updateCustomerSatisied() {
        self.customerSatisified += 1
    }
    
    func updateMoneyEarned(_ money: Int) {
        self.moneyEarned += money
    }
    
    func updateMoneyUsed(_ money: Int) {
        self.moneyUsed += money
    }
    
    func updateViewSwithingTimes() {
        self.viewSwitchingTimes += 1
    }
    
    func createScore() {
        self.score = Score(
            id: self.id,
            date: self.date,
            customerSatisified: self.customerSatisified,
            moneyEarned: self.moneyEarned,
            moneyUsed: self.moneyUsed,
            viewSwitchingTimes: self.viewSwitchingTimes
        )
    }
    
    func exitGame(
        coordinator: any AppCoordinatorProtocol,
        gameState: GameState,
        modelContext: ModelContext
    ) {
        guard let score = self.score else { return }
        
        do {
            modelContext.insert(score.mapToDTO())
            try modelContext.save()
            coordinator.dismissFullScreenCover()
            coordinator.pop()
        }
        catch {
            debugPrint("ERROR insert score")
        }
    }
    
    func getScore() -> Score? {
        return self.score
    }
}
