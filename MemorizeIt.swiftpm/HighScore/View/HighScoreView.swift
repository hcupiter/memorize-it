//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/02/25.
//

import SwiftUI
import SwiftData

struct HighScoreView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var fontManager: FontManager
    
    @StateObject private var scoreList: ScoresViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Highscores")
                .font(fontManager.getFont(.title, .bold))
            
            VStack(spacing: 8) {
                if scoreList.scoreList.isEmpty {
                    Text("No Data...")
                        .font(fontManager.getFont())
                        .padding(.horizontal, 16)
                        .background(Color(uiColor: .systemFill), in: LabelBackgroundShape()
                        )
                }
                else {
                    ForEach(scoreList.scoreList, id: \.id) { score in
                        Button {
                            coordinator.presentSheet(
                                .scoreDetail(
                                    score: score
                                )
                            )
                        } label: {
                            ScoreCardView(score: score)
                        }
                        .foregroundStyle(Color.black)

                    }
                }
            }
            
            Spacer()
            
            Button {
                coordinator.pop()
            } label: {
                Text("Back")
                    .font(fontManager.getFont(.title3, .bold))
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .foregroundStyle(Color.white)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(Color.blue)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear() {
            scoreList.getScore(modelContext: modelContext)
        }
        .padding(.vertical, 32)
        .safeAreaPadding(.horizontal, 16)
    }
}
