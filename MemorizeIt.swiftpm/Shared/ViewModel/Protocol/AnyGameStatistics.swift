//
//  AnyGameStatistics.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/02/25.
//


import Foundation
import SwiftData

protocol GameStatisticsProtocol: ObservableObject {
    var score: Score? { get set }
    
    func updateCustomerSatisied()
    func updateMoneyEarned(_ money: Int)
    func updateMoneyUsed(_ money: Int)
    func updateViewSwithingTimes()
    func createScore() -> Void
    func exitGame(
        coordinator: any AppCoordinatorProtocol,
        gameState: GameState,
        modelContext: ModelContext
    )
}

// Type eraser for GameStatisticsProtocol
class AnyGameStatistics: GameStatisticsProtocol {
    private var _anyGameStatistics: any GameStatisticsProtocol
    
    @Published var score: Score?
    
    init(_ anyGameStatistics: any GameStatisticsProtocol) {
        _anyGameStatistics = anyGameStatistics
    }
    
    func updateCustomerSatisied() {
        _anyGameStatistics.updateCustomerSatisied()
    }
    
    func updateMoneyEarned(_ money: Int) {
        _anyGameStatistics.updateMoneyEarned(money)
    }
    
    func updateMoneyUsed(_ money: Int) {
        _anyGameStatistics.updateMoneyUsed(money)
    }
    
    func updateViewSwithingTimes() {
        _anyGameStatistics.updateViewSwithingTimes()
    }
    
    func createScore() {
        _anyGameStatistics.createScore()
        score = _anyGameStatistics.score
    }
    
    func exitGame(
        coordinator: any AppCoordinatorProtocol,
        gameState: GameState,
        modelContext: ModelContext
    ) {
        _anyGameStatistics.exitGame(coordinator: coordinator, gameState: gameState, modelContext: modelContext)
    }
}
