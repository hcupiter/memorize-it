//
//  SwiftUIView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/02/25.
//

import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var fontManager: FontManager
    @EnvironmentObject var coordinator: AppCoordinator
    
    @StateObject private var viewModel: TutorialViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Tutorial")
                    .font(fontManager.getFont(.title, .bold))
                
                TutorialContentView(tutorial: viewModel.tutorialList[viewModel.currentPage])
                    .id(viewModel.tutorialList[viewModel.currentPage].id)
                    .padding(.vertical, 24)
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Button {
                        viewModel.previous()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(
                        viewModel.isPrevDisabled() ? Color(uiColor: .systemGray).gradient : Color(uiColor: .systemTeal).gradient
                    )
                    
                    Button {
                        viewModel.next()
                    } label: {
                        Image(systemName: "chevron.forward")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(
                        viewModel.isNextDisabled() ? Color(uiColor: .systemGray).gradient : Color(uiColor: .systemTeal).gradient
                    )


                }
                Button {
                    coordinator.pop()
                } label: {
                    Text("Back")
                        .font(fontManager.getFont(.title3))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 16)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color.blue)
            }

        }
        .padding(.vertical, 32)
        .padding(.horizontal, 16)
    }
}
