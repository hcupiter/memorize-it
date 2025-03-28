//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/02/25.
//

import SwiftUI
import SwiftData

struct EndView<GameStatisticViewModel>: View
    where GameStatisticViewModel: GameStatisticsProtocol
{
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var fontManager: FontManager
    
    @ObservedObject var gameState: GameState
    @ObservedObject var statistics: GameStatisticViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Result")
                .font(fontManager.getFont(.title, .bold))
            
            if let score = statistics.score {
                VStack(spacing: 32) {
                    VStack(spacing: 24) {
                        Image("person-celebrate")
                            .resizable()
                            .frame(width: 400, height: 400)
                        VStack(spacing: 4) {
                            Text("Great Job!")
                                .font(fontManager.getFont(.title3, .bold))
                            Text("Here's what we did today!")
                                .font(fontManager.getFont(.title5))
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading) {
                                Text(score.toDisplayDate)
                                    .font(fontManager.getFont(.title5, .bold))
                                Text(score.toDisplayDateTime)
                                    .font(fontManager.getFont(.headline))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Score:")
                                    .font(fontManager.getFont(.headline))
                                Text("\(score.value)")
                                    .font(fontManager.getFont(.title4, .bold))
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                VStack {
                                    HStack {
                                        Text("Satisifed Customer: ")
                                        Spacer()
                                        Text("\(score.customerSatisified) customer(s)")
                                            .font(fontManager.getFont(.body, .bold))
                                    }
                                    Divider()
                                }
                                
                                VStack {
                                    HStack {
                                        Text("Earned:")
                                        Spacer()
                                        Text("\(score.moneyEarned) coin")
                                            .font(fontManager.getFont(.body, .bold))
                                    }
                                    Divider()
                                }
                                
                                VStack {
                                    HStack {
                                        Text("Used:")
                                        Spacer()
                                        Text("\(score.moneyUsed) coin")
                                            .font(fontManager.getFont(.body, .bold))
                                    }
                                    Divider()
                                }
                                
                                VStack {
                                    HStack {
                                        Text("Time Used for Switching Views:")
                                        Spacer()
                                        Text("\(score.timeWasted) second(s)")
                                            .font(fontManager.getFont(.body, .bold))
                                    }
                                    Divider()
                                }
                            }
                            .font(fontManager.getFont())
                            .padding(.top, 8)
                        }
                        
                        Spacer()
                        
                        Button {
                            statistics.exitGame(
                                coordinator: coordinator,
                                gameState: gameState,
                                modelContext: modelContext
                            )
                        } label: {
                            Text("Close")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .font(fontManager.getFont(.title3))
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        .tint(.blue)
                    }
                    .padding(24)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            else {
                Text("No Data...")
                    .font(fontManager.getFont())
                    .padding(.horizontal, 16)
                    .background(Color(uiColor: .systemFill), in: LabelBackgroundShape()
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .safeAreaPadding(.horizontal, 16)
        .onAppear(){
            statistics.createScore()
        }
    }
}
