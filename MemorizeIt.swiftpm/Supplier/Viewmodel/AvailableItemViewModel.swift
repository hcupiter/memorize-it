//
//  AvailableItemViewModel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 18/01/25.
//

import Foundation

class AvailableItemViewModel: ObservableObject {
    @Published var availableItem: [Item] = []
    @Published var cartItem: [Int:Stock] = [:]
    @Published var logMessage: [String] = []
    @Published var totalCartPrice: Int = 0
    
    var toDisplayCartItem: [Stock] {
        Array(self.cartItem.values.sorted(
            by: { $0.item.id < $1.item.id })
        )
    }
    
    func setup() {
        // Setup data for available item
        availableItem.append(
            contentsOf: Item.data.sorted(by: {$0.id < $1.id}))
    }
    
    func handleTap(event: ItemChangedEvent) {
        switch event {
        case .add(let item, let quantity):
            addItemToCart(item: item, quantity: quantity)
        case .substract(let item, let quantity):
            substractItemFromCart(item: item, quantity: quantity)
        }
    }
    
    @MainActor func checkout(
        coordinator: any AppCoordinatorProtocol,
        balance: Int,
        storage: ItemStorable,
        purchase: BalanceUpdatable,
        statistics: AnyGameStatistics
    ) {
        // Make sure user have enough money to checkout
        guard totalCartPrice <= balance else {
            coordinator.presentNotification(
                .notification(
                    title: "Failed to checkout!",
                    description: "You don't have enough money..."
                )
            )
            return
        }
        
        // Substract User Balance
        purchase.updateBalance(
            event: .substract(by: totalCartPrice)
        )
        
        // Update the item stock
        for cartItem in cartItem.values {
            storage.updateItemStock(
                event: .add(
                    item: cartItem.item,
                    quantity: cartItem.quantity
                )
            )
        }
        
        // Update Statistics
        statistics.updateMoneyUsed(totalCartPrice)
        
        // Reset data
        totalCartPrice = 0
        cartItem.removeAll()
    }
    
    private func addItemToCart(item: Item, quantity: Int) {
        // Append quantity if item is already in cart
        if cartItem[item.id] != nil {
            cartItem[item.id]?.quantity += quantity
            debugPrint("[SUCCESS]: Added quantity to \(item.name) to cart")
        }
        // Create new instance if item isn't in cart
        else {
            let newStock = Stock(id: UUID(), item: item, quantity: 1)
            cartItem[item.id] = newStock
            debugPrint("[SUCCESS]: Added \(item.name) to cart")
        }
        addCartTotalPrice(item: item, quantity: quantity)
    }
    
    private func substractItemFromCart(item: Item, quantity: Int) {
        // Validate the item is still in the cart
        guard let stock = cartItem[item.id] else {
            debugPrint("[ERROR]: No \(item.name) to substract")
            return
        }
        
        // Remove instance if the quantity is only 1
        if stock.quantity - quantity < 1 {
            cartItem.removeValue(forKey: item.id)
            debugPrint("[SUCCESS]: Removed \(item.name) from cart")
        }
        else {
            // Substract the quantity
            cartItem[item.id]?.quantity -= quantity
            debugPrint("[SUCCESS]: Substract \(item.name) quantity")
        }
        substractCartTotalPrice(item: item, quantity: quantity)
    }
    
    private func addCartTotalPrice(item: Item, quantity: Int) {
        let price = item.price * quantity
        totalCartPrice += price
    }
    
    private func substractCartTotalPrice(item: Item, quantity: Int) {
        let price = item.price * quantity
        totalCartPrice -= price
    }
}

