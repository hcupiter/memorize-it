//
//  ItemCardView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import SwiftUI

struct CatalogItemCardView: View {
    @EnvironmentObject var fontManager: FontManager
    
    let item: Item
    var tint: Color = Color.white
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center) {
                if let uiImage = UIImage(named: "\(item.imageName)") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 64, height: 64)
                }
                else {
                    Image("item-model-default-1")
                        .resizable()
                        .frame(width: 64, height: 64)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(item.name)")
                        .font(fontManager.getFont(.body, .bold))
                        .multilineTextAlignment(.leading)
                    Text("$ \(item.price)")
                        .font(fontManager.getFont(.body, .sans))
                }
                .frame(alignment: .leading)
            }
            .padding(16)
            .frame(height: 170)
            .frame(maxWidth: .infinity)
        }
        .background(tint, in: ItemCardViewBackgroundShape())
    }
}
