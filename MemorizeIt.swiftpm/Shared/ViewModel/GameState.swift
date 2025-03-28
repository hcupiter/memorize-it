//
//  GameState.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

import SwiftUI
import Combine
import Subsonic

class GameState: ObservableObject, BalanceUpdatable {
    @Published var player: SubsonicController = .shared
    @Published var currentView: GameViewType = .counter
    
    @Published var currentTime: Int = 0
//    @Published var endTime: Int = TimeConverter
//        .convert(5, from: .minute, to: .second)
    @Published var endTime: Int = 300
    
    var remainingTime: Int {
        if endTime - currentTime < 0 {
            return 0
        }
        return endTime - currentTime
    }
    
    @Published var totalSold: Int = 0
    @Published var totalCoin: Int = 500
    
    @Published var isPaused: Bool = false
    
    @Published var timer: Timer?
    
    var cancellables = Set<AnyCancellable>()
    
    var displayedCoin: String {
        if totalCoin >= 1_000_000_000 {
            return "\(Double(totalCoin) / 1_000_000_000)B"
        } else if totalCoin >= 1_000_000 {
            return "\(Double(totalCoin) / 1_000_000)M"
        } else if totalCoin >= 1_000 {
            return "\(Double(totalCoin) / 1_000)K"
        } else {
            return "\(totalCoin)"
        }
    }
    
    func updateBalance(event: BalanceChangedEvent) {
        switch event {
        case .add(by: let balance):
            self.totalCoin += balance
        case .substract(by: let balance):
            self.totalCoin -= balance
        }
    }
    
    func switchView(to view: GameViewType, statistics: any GameStatisticsProtocol) {
        self.currentView = view
        statistics.updateViewSwithingTimes()
        self.currentTime += Constant.timeSwitchView
    }
    
    func startTimer(
        coordinator: any AppCoordinatorProtocol,
        statistics: AnyGameStatistics,
        customerList: any CustomerListProtocol
    ) {
        let timeInterval = 1.0
        self.playSound()
        
        Timer.publish(
            every: timeInterval,
            on: .main,
            in: .common
        )
        .autoconnect()
        .sink { [weak self] _ in
            guard let self = self else { return }
            if isPaused == false {
                // Increment currentTime
                self.currentTime += 1
                
                // Stop the timer when reaching the end time
                if self.currentTime >= self.endTime {
                    self.stopTimer()
                    player.stopAllManagedSounds()
                    coordinator.presentFullScreenCover(
                        .endScreen(statistics: statistics, gameState: self)
                    )
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        SoundFXManager.playSound(soundFX: .gamecompleted)
                    })
                }
                else {
                    trySummonCustomer(customerList: customerList)
                }
            }
        }
        .store(in: &cancellables)
    }
    
    func stopTimer() {
        self.cancellables.removeAll()
        
    }
    
    func pauseGame(coordinator: AppCoordinatorProtocol) {
        self.isPaused.toggle()
        
        if isPaused {
            coordinator.presentSheet(.exitConfirmation(gameState: self))
        }
        else {
            coordinator.dismissSheet(onDismiss: {})
        }
        
    }
    
    func exitGame(coordinator: AppCoordinatorProtocol) {
        stopSound()
        coordinator.dismissSheet(onDismiss: {})
        coordinator.pop()
    }
    
    func trySummonCustomer(customerList: any CustomerListProtocol) {
        // Customer have 50% chance to appear every second
        let random = Int.random(in: 0...100)
        if random < 50 {
            customerList.addRandomCustomer()
        }
    }
}

private extension GameState {
    func playSound() {
        player.play(sound: "MonkeysSpinningMonkeys.mp3", repeatCount: .continuous)
    }
    
    func stopSound() {
        player.stopAllManagedSounds()
    }
}
