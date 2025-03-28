//
//  DeliveryPackedItemSelectCustomerView.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 10/02/25.
//


import SwiftUI

struct DeliveryPackedItemSelectCustomerView: View {
    @ObservedObject var customerList: AnyCustomerList
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(
                    customerList.getDisplayedCustomerData(),
                    id: \.id) { customer in
                        Button {
                            customerList.set(activeCustomer: customer)
                        } label: {
                            DeliveryPackedItemCustomerOptionCardView(
                                customer: customer,
                                isActive: isActive(
                                    customer: customer,
                                    selectedCustomer: customerList.selectedCustomer
                                )
                            )
                        }

                    }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    func isActive(customer: Customer, selectedCustomer: Customer?) -> Bool {
        guard let selectedCustomer = selectedCustomer else {
            return false
        }
        
        if customer.id == selectedCustomer.id {
            return true
        }
        return false
    }
}
