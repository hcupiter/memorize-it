//
//  CustomerListViewModel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

import Foundation
import Combine

class CustomerListViewModel: ObservableObject, PackedItemSelectable, CustomerListProtocol {
    let customerListPublisher: CurrentValueSubject<[UUID : Customer], Never>
    let selectedCustomerPublisher: CurrentValueSubject<Customer?, Never>
    let selectedPackedItemPublisher: CurrentValueSubject<PackedItem?, Never>
    let errorMessagePublisher: CurrentValueSubject<String?, Never>
    
    @Published var customerList: [UUID:Customer] = [:] {
        didSet {
            customerListPublisher.send(customerList)
        }
    }
    @Published var selectedCustomer: Customer? {
        didSet {
            selectedCustomerPublisher.send(selectedCustomer)
        }
    }
    @Published var selectedPackedItem: PackedItem? {
        didSet {
            selectedPackedItemPublisher.send(selectedPackedItem)
        }
    }
    @Published var errorMessage: String? {
        didSet {
            errorMessagePublisher.send(errorMessage)
        }
    }
    
    init(customerList: [UUID : Customer]? = nil) {
        self.customerListPublisher = .init([:])
        self.selectedCustomerPublisher = .init(nil)
        self.selectedPackedItemPublisher = .init(nil)
        self.errorMessagePublisher = .init(nil)
        
        if let customerList = customerList {
            self.customerList = customerList
        }
        else {
            addRandomCustomer()
            addRandomCustomer()
            addRandomCustomer()
        }
    }
    
    func getDisplayedCustomerData() -> [Customer] {
        return self.customerList.values.sorted(by: {$0.dateAppear < $1.dateAppear})
    }
    
    func addRandomCustomer() {
        // Limit make sure only have 3 customer present
        guard self.customerList.count < 3 else { return }
        
        let customerName = Customer.getRandomNames()
        let requests = Stock.generateRandomStock()
        let newCustomer: Customer = .init(
            id: UUID(),
            name: customerName,
            requestList: requests,
            dateAppear: Date.now
        )
        
        self.customerList[newCustomer.id] = newCustomer
    }
    
    func removeCustomer(_ id: UUID) {
        customerList.removeValue(forKey: id)
        debugPrint("[SUCCESS]: Removed customer \(id)")
    }
    
    func sellPackedItem(
        customer: Customer,
        appCoordinator: AppCoordinatorProtocol,
        updatePackedItemFrom: PackedItemSellable,
        addBalanceTo: BalanceUpdatable,
        statistics: AnyGameStatistics
    ) {
        guard let packedItem = self.selectedPackedItem else {
            debugPrint("[ERROR]: No customer or packed item selected")
            return
        }
        
        if isCustomerRequestFulfilled(customer: customer, packedItem: packedItem) {
            Task {
                await SoundFXManager.playSound(soundFX: .ordercompleted)
            }
            self.customerList.removeValue(forKey: customer.id)
            updatePackedItemFrom.sellPackedItem(packedItem)
            
            let balanceGet = calculateTotalSellPrice(packedItem: packedItem)
            addBalanceTo.updateBalance(event: .add(by: balanceGet))
            
            unsetData()
            appCoordinator.dismissSheet(onDismiss: {
                self.errorMessage = nil
            })
            debugPrint("[SUCCESS]: items sold")
            statistics.updateCustomerSatisied()
            statistics.updateMoneyEarned(balanceGet)
        }
        else {
            Task {
                await SoundFXManager.playSound(soundFX: .whip)
            }
            errorMessage = "\(customer.name) didn't order this item!"
            unsetData()
        }
    }
    
    func set(activeCustomer: Customer) {
        // If nil, set the selected customer
        guard let selectedCustomer = self.selectedCustomer else {
            self.selectedCustomer = activeCustomer
            self.errorMessage = nil
            return
        }
        
        // If selected customer already selected, unselect it
        if selectedCustomer.id == activeCustomer.id {
            self.selectedCustomer = nil
        }
        // else set new selected customer
        else {
            self.selectedCustomer = activeCustomer
            self.errorMessage = nil
        }
    }
    
    func set(
        packedItem: PackedItem,
        coordinator: any AppCoordinatorProtocol,
        updatePackedItemFrom finishedPackedItemList: FinishedPackedItemListViewModel,
        addBalanceTo gameState: GameState,
        statistics: AnyGameStatistics
    ) {
        // If nil, set the selected packed item
        guard let selectedPackedItem = self.selectedPackedItem else {
            self.selectedPackedItem = packedItem
            coordinator.presentSheet(
                .deliver(
                    packedItem: packedItem,
                    customerList: AnyCustomerList(self),
                    finishedPackedItemList: finishedPackedItemList,
                    gameState: gameState,
                    statistics: statistics,
                    onDismiss: {
                        self.errorMessage = nil
                        self.selectedPackedItem = nil
                        self.selectedCustomer = nil
                    }
                )
            )
            return
        }
        
        // if selected packed item already selected, unselect it
        if selectedPackedItem.id == packedItem.id {
            self.selectedPackedItem = nil
        }
        // else set new selected packed item
        else {
            self.selectedPackedItem = packedItem
            coordinator.presentSheet(
                .deliver(
                    packedItem: packedItem,
                    customerList: AnyCustomerList(self),
                    finishedPackedItemList: finishedPackedItemList,
                    gameState: gameState,
                    statistics: statistics,
                    onDismiss: {
                        self.errorMessage = nil
                        self.selectedPackedItem = nil
                        self.selectedCustomer = nil
                    }
                )
            )
        }
    }
    
    func unsetData(){
        self.selectedCustomer = nil
//        self.selectedPackedItem = nil
        debugPrint("[SUCCESS]: Cancelled sell item")
    }
    
    private func isCustomerRequestFulfilled(
        customer: Customer,
        packedItem: PackedItem
    ) -> Bool {
        // Convert to dict for faster lookup
        let requestDict = Dictionary<Int, Stock>.mapFromArray(
            array: customer.requestList,
            transform: {
                (key: $0.item.id, value: $0.quantity)
            }
        )
        
        let stockDict = Dictionary<Int, Stock>.mapFromArray(
            array: packedItem.stocks,
            transform: {
                (key: $0.item.id, value: $0.quantity)
            }
        )
        
        // Search both dict and ensure the value all the same
        for (itemId, requestedQuantity) in requestDict {
            guard let packedQuantity = stockDict[itemId],
                  packedQuantity == requestedQuantity else {
                return false
            }
        }
        
        for (itemId, packedQuantity) in stockDict {
            guard let requestedQuantity = requestDict[itemId],
                  requestedQuantity == packedQuantity else {
                return false
            }
        }
        
        return true
    }
    
    private func calculateTotalSellPrice(packedItem: PackedItem) -> Int {
        var balance: Int = 0
        for stock in packedItem.stocks {
            let itemPrice: Double
            
            if stock.item.price <= 0 {
                itemPrice = 1
            }
            else {
                itemPrice = Double(stock.item.price)
            }
            
            balance += Int(itemPrice * 1.5 * Double(stock.quantity))
        }
        return balance
    }
    
}
