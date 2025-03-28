//
//  AppCoordinator.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 31/01/25.
//

import SwiftUI

class AppCoordinator: ObservableObject, AppCoordinatorProtocol {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    @Published var notification: MemorizeNotification?
    
    func push(_ screen: Screen) {
        self.path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ cover: FullScreenCover) {
        self.fullScreenCover = cover
    }
    
    func presentNotification(_ notification: MemorizeNotification) {
        self.notification = notification
    }
    
    func pop() {
        self.path.removeLast()
    }
    
    func popAll() {
        self.path.removeLast(self.path.count)
    }
    
    func dismissSheet(onDismiss: (() -> ())? = nil) {
        self.sheet = nil
        if let onDismiss = onDismiss {
            onDismiss()
        }
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    func dismissNotification() {
        self.notification = nil
    }
    
    // MARK: - Presentation Style Provider
    @ViewBuilder
    @MainActor
    func build(_ screen: Screen) -> some View{
        switch screen {
        case .game:
            VStack {
                GameView()
            }
        case .mainMenu:
            VStack {
                ContentView()
            }
        case .debug:
            VStack {
                DebugView()
            }
        case .highScore:
            VStack {
                HighScoreView()
            }
        case .credit:
            VStack {
                CreditView()
            }
        case .tutorial:
            VStack {
                TutorialView()
            }
        }
    }
    
    @ViewBuilder
    @MainActor
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        case .deliver(
            let packedItem,
            let customerList,
            let finishedPackedItemList,
            let gameState,
            let statistics,
            let onDismiss
        ):
            VStack {
                DeliveryPackedItemView(
                    packedItem: packedItem,
                    customerList: customerList,
                    finishedPackedItemList: finishedPackedItemList,
                    gameState: gameState,
                    statistics: statistics,
                    onDismiss: onDismiss
                )
            }
            .interactiveDismissDisabled()
            
        case .viewPackItemDetail(
            let packedItem,
            let finishedItemList,
            let stockList,
            let onDismiss
        ):
            VStack {
                PackItemDetailModalView(
                    finishedItemList: finishedItemList,
                    stockList: stockList,
                    packedItem: packedItem,
                    onDismiss: onDismiss
                )
            }
            .interactiveDismissDisabled()
            
        case .exitConfirmation(let gameState):
            VStack {
                CounterGameExitConfirmationSheet(
                    gameState: gameState
                )
            }
            .interactiveDismissDisabled()
            
        case .scoreDetail(let score):
            VStack {
                HighScoreDetailScore(score: score)
            }
            .interactiveDismissDisabled()
        }
    }
    
    @MainActor
    @ViewBuilder
    func build(_ cover: FullScreenCover) -> some View {
        switch cover {
        case .endScreen(let statistics, let gameState):
            VStack {
                EndView<AnyGameStatistics>(gameState: gameState, statistics: statistics)
            }
        }
    }
    
    @MainActor
    @ViewBuilder
    func build(_ notification: MemorizeNotification) -> some View {
        switch notification {
        case .notification(let imageName, let title, let description):
            ZStack {
                NotificationView(imageName: imageName, title: title, description: description)
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        // Detect upward swipe
                        if value.translation.height < -50 {
                            self.dismissNotification()
                        }
                    }
            )
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.dismissNotification()
                })
            }
        }
    }
}
