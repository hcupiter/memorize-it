//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 21/02/25.
//

import SwiftUI

struct TutorialContentView: View {
    @EnvironmentObject var fontManager: FontManager
    
    let tutorial: Tutorial
    
    var body: some View {
        VStack() {
            VStack {
                Text("\(tutorial.title)")
                    .font(fontManager.getFont(.title2, .bold))
                Image("\(tutorial.imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 500)
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(tutorial.content, id: \.self) { content in
                        Text(content)
                            .font(fontManager.getFont(.title5))
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(maxWidth: .infinity)
        }
    }
}
