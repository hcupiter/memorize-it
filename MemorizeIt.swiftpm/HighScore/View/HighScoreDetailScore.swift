//
//  HighScoreDetailScore.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/02/25.
//

import SwiftUI

struct HighScoreDetailScore: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var fontManager: FontManager
    
    let score: Score
    
    var body: some View {
        VStack(alignment: .leading) {
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
                    coordinator.dismissSheet()
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
}
