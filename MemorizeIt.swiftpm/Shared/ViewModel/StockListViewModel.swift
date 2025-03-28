//
//  StockListViewModel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 19/01/25.
//

import Foundation

class StockListViewModel: ObservableObject, ItemStorable, PackedItemUnpackable {
    @Published var stockList: [Int:Stock] = [:] // itemID : Stock
    
    init(stockList: [Int : Stock]? = nil) {
        if let stockList = stockList {
            self.stockList = stockList
        }
    }

    func updateItemStock(event: ItemChangedEvent) {
        switch event {
        case .add(let item, let quantity):
            addItemStock(item: item, quantity: quantity)
        case .substract(let item, let quantity):
            removeItemStock(item: item, quantity: quantity)
        }
    }
    
    func unpack(packedItem: PackedItem) {
        for stock in packedItem.stocks {
            if stockList[stock.item.id] != nil {
                stockList[stock.item.id]?.quantity += stock.quantity
            }
            else {
                stockList[stock.item.id] = stock
            }
        }
    }
    
    private func removeItemStock(item: Item, quantity: Int) {
        // Validate the item must be on stock list
        guard let stock = stockList[item.id] else {
            debugPrint("[ERROR]: Item ID \(item.id) is not found on stock list")
            return
        }
        
        if stock.quantity - quantity < 1 {
            stockList.removeValue(forKey: item.id)
            debugPrint("[SUCCESS]: Removed \(item.name) from stock")
        }
        else {
            stockList[item.id]?.quantity -= quantity
            debugPrint("[SUCCESS]: Substract \(quantity) \(item.name) from stock")
        }
    }
    
    private func addItemStock(item: Item, quantity: Int) {
        // Validate the item must be in stock list
        guard stockList[item.id] != nil else {
            let newStock = Stock(id: UUID(), item: item, quantity: quantity)
            stockList[item.id] = newStock
            debugPrint("[SUCCESS]: Added new \(item.name) to stock")
            return
        }
        
        // If the item is in the stock list, update the quantity
        stockList[item.id]?.quantity += quantity
        debugPrint("[SUCCESS]: Added \(quantity) \(item.name) to stock")
    }
}
