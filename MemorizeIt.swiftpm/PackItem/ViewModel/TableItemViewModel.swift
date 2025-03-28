//
//  PackedItemViewModel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 17/01/25.
//

import SwiftUI

class TableItemViewModel: ObservableObject {
    @Published var listPackedItem: [Int:Stock] = [:]
    
    var toDisplayListPackedItem: [Stock] {
        Array(self.listPackedItem.values)
            .sorted(by: { $0.item.id < $1.item.id})
    }
    
    func handleTap(event: ItemChangedEvent, onComplete: ItemStorable) {
        switch event {
        case .add(let item, let quantity):
            addItemToTempPack(item: item, quantity: quantity)
            onComplete.updateItemStock(event: .substract(item: item, quantity: 1))
        case .substract(let item, let quantity):
            removeItemFromTempPack(item: item, quantity: quantity)
            onComplete.updateItemStock(event: .add(item: item, quantity: 1))
        }
    }
    
    func packItem(sendPackEvent: ItemPackable) {
        guard listPackedItem.isEmpty == false else { return }
        
        let stocks: [Stock] = Array(
            listPackedItem.values
                .sorted(by: {$0.item.id < $1.item.id})
        )
        let packedItem = PackedItem(
            id: UUID(),
            dateCreated: .now,
            stocks: stocks
        )
        
        listPackedItem.removeAll()
        sendPackEvent.updatePackedItem(packedItem: packedItem)
        debugPrint("[SUCESSS]: Item Packed")
    }
    
    private func addItemToTempPack(item: Item, quantity: Int) {
        // If there's already item added, don't create another data
        if listPackedItem[item.id] != nil {
            listPackedItem[item.id]?.quantity += quantity
            debugPrint("[SUCCESS]: Item \(item.name) quantity added")
        }
        // else, append new stock data
        else {
            let newStock = Stock(
                id: UUID(),
                item: item,
                quantity: quantity
            )
            listPackedItem[item.id] = newStock
            debugPrint("[SUCCESS]: Item \(item.name) added")
        }
    }
    
    private func removeItemFromTempPack(item: Item, quantity: Int) {
        // Validate item is in list packed item
        guard let stock = listPackedItem[item.id] else {
            debugPrint("[ERROR]: Item \(item) is not detected in list Packed Item")
            return
        }
        
        // If the item is one quantity, remove the instance
        guard stock.quantity > 1 else {
            listPackedItem.removeValue(forKey: item.id)
            debugPrint("[SUCCESS]: Remove item \(item.name)")
            return
        }
        
        listPackedItem[item.id]?.quantity -= quantity
        debugPrint("[SUCCESS]: Item \(item.name) quantity decreased")
    }

}
