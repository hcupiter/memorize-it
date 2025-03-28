//
//  GameView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/01/25.
//

import SwiftUI
import Subsonic

struct GameView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var fontManager: FontManager
    
    @StateObject private var gameState: GameState = .init()
    @StateObject private var stockList: StockListViewModel = .init()
    @StateObject private var customerList: AnyCustomerList =  .init(CustomerListViewModel())
    @StateObject private var tableItemList: TableItemViewModel = .init()
    @StateObject private var packedItemList: FinishedPackedItemListViewModel = .init()
    
    @StateObject private var statistics: AnyGameStatistics = .init(GameStatistics())
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    // Coin
                    HStack(alignment: .top) {
                        Image("Coin")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("\(gameState.displayedCoin)")
                            .font(fontManager.getFont(.title3, .bold))
                            .foregroundStyle(Color.fromHex("#7F752D"))
                    }
                    
                    // Time
                    HStack {
                        Image("clock")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("\(gameState.remainingTime)")
                            .font(fontManager.getFont(.title3, .bold))
                            .foregroundStyle(Color.fromHex("#1f4c7b"))
                    }
                }
                
                Spacer()
                HStack(spacing: 16) {
                    Rectangle()
                        .frame(width: 10, height: 40)
                        .foregroundStyle(gameState.currentView.color)
                    Text("\(gameState.currentView.title)")
                        .font(fontManager.getFont(.title, .bold))
                }
            }
            
            .padding(16)
            
            switch gameState.currentView {
            case .counter:
                CounterView()
                    .transition(.opacity)

            case .store:
                SupplierView()
                    .transition(.opacity)
                
            case .pack:
                PackItemView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: gameState.currentView)
        .environmentObject(gameState)
        .environmentObject(stockList)
        .environmentObject(customerList)
        .environmentObject(packedItemList)
        .environmentObject(statistics)
        .environmentObject(tableItemList)
        .onAppear() {
            gameState.startTimer(
                coordinator: coordinator,
                statistics: statistics,
                customerList: customerList
            )
        }
    }
}

struct Trapezoid: Shape {
    var topWidthFraction: CGFloat = 0.5 // Top edge width as a fraction of the view's width
    
    var animatableData: CGFloat {
        get { topWidthFraction }
        set { topWidthFraction = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let topInset = (1 - topWidthFraction) * rect.width / 2
        var path = Path()
        
        // Define the four points of the trapezoid
        path.move(to: CGPoint(x: rect.minX + topInset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topInset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}
