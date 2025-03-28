//
//  ItemDeliveryViewModel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 31/01/25.
//

import Foundation

class ItemDeliveryViewModel: ObservableObject {
    let selectedItem: PackedItem
    
    init(selectedItem: PackedItem) {
        self.selectedItem = selectedItem
    }
    
}
