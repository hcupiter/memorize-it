//
//  DeliveryPackedItemCustomerOptionCardView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 10/02/25.
//


import SwiftUI

struct DeliveryPackedItemCustomerOptionCardView: View {
    @EnvironmentObject var fontManager: FontManager
    
    let customer: Customer
    let isActive: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(customer.name)")
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .foregroundStyle(Color.black)
                .font(fontManager.getFont())
        }
        .frame(maxWidth: .infinity)
        .background(determineBackgroundColor(), in: DeliveryPackedItemCustomerOptionCardBackgroundShape())
    }
    
    private func determineBackgroundColor() -> Color {
        return isActive ? .yellow : Color(uiColor: .systemFill)
    }
    
    private struct DeliveryPackedItemCustomerOptionCardBackgroundShape: Shape {
        func path(in rect: CGRect) -> Path {
            RoundedRectangle(cornerRadius: 8)
                .path(in: rect)
        }
    }
}
