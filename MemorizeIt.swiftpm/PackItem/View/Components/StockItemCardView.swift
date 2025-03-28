//
//  StockItemCardView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

import SwiftUI

struct StockItemCardView: View {
    @EnvironmentObject var fontManager: FontManager
    
    let stock: Stock
    var tint: Color = Color.white
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center) {
                if let uiImage = UIImage(named: "\(stock.item.imageName)") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 64, height: 64)
                }
                else {
                    Image("item-model-default-1")
                        .resizable()
                        .frame(width: 64, height: 64)
                }
                
                VStack(alignment: .center, spacing: 0) {
                    Text("\(stock.item.name)")
                        .font(fontManager.getFont(.callout, .mono))
                    Text("Quantity: \(stock.quantity)")
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
