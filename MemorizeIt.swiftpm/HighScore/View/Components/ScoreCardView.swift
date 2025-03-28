//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/02/25.
//

import SwiftUI

struct ScoreCardView: View {
    @EnvironmentObject var fontManager: FontManager
    
    let score: Score
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(score.toDisplayDate)")
                        .font(fontManager.getFont(.body))
                    Text("Score: \(score.value)")
                        .font(fontManager.getFont(.title3, .bold))
                }
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundStyle(Color.gray)
            }
            .padding(16)
        }
        .background(Color(uiColor: .systemFill), in: ScoreCardBackgroundShape())
    }
}

private struct ScoreCardBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        return RoundedRectangle(cornerRadius: 6)
            .path(in: rect)
    }
}
