//
//  NotificationView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 22/02/25.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject private var fontManager: FontManager
    
    let imageName: String?
    let title: String?
    let description: String
    
    var body: some View {
        ZStack {
            HStack(spacing: 16) {
                if let imageName = imageName {
                    Image("\(imageName)")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .aspectRatio(contentMode: .fill)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    if let title = title {
                        Text(title)
                            .font(fontManager.getFont(.title5, .bold))
                    }
                    
                    Text(description)
                        .font(fontManager.getFont(.body))
                }
                .foregroundStyle(Color.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 600)
        .background(.red.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
