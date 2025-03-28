//
//  AnyCustomerList.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/02/25.
//

import Foundation
import Combine

protocol CustomerListProtocol: ObservableObject, PackedItemSelectable {
    // Existing properties as PassthroughSubjects or CurrentValueSubjects
    var customerListPublisher: CurrentValueSubject<[UUID:Customer], Never> { get }
    var selectedCustomerPublisher: CurrentValueSubject<Customer?, Never> { get }
    var selectedPackedItemPublisher: CurrentValueSubject<PackedItem?, Never> { get }
    var errorMessagePublisher: CurrentValueSubject<String?, Never> { get }
    
    var customerList: [UUID:Customer] { get set }
    var selectedCustomer: Customer? { get set }
    var selectedPackedItem: PackedItem? { get set }
    var errorMessage: String? { get set }
    
    func getDisplayedCustomerData() -> [Customer]
    func addRandomCustomer()
    func removeCustomer(_ id: UUID)
    func sellPackedItem(
        customer: Customer,
        appCoordinator: AppCoordinatorProtocol,
        updatePackedItemFrom: PackedItemSellable,
        addBalanceTo: BalanceUpdatable,
        statistics: AnyGameStatistics
    )
    func set(activeCustomer: Customer)
    func set(
        packedItem: PackedItem,
        coordinator: any AppCoordinatorProtocol,
        updatePackedItemFrom finishedPackedItemList: FinishedPackedItemListViewModel,
        addBalanceTo gameState: GameState,
        statistics: AnyGameStatistics
    )
    func unsetData()
}

// Type Eraser Class
class AnyCustomerList: CustomerListProtocol {
    private var _anyCustomerList: any CustomerListProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Initialize publishers
    let customerListPublisher = CurrentValueSubject<[UUID:Customer], Never>([:])
    let selectedCustomerPublisher = CurrentValueSubject<Customer?, Never>(nil)
    let selectedPackedItemPublisher = CurrentValueSubject<PackedItem?, Never>(nil)
    let errorMessagePublisher = CurrentValueSubject<String?, Never>(nil)
    
    @Published var customerList: [UUID : Customer] = [:] {
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
    
    init(_ anyCustomerList: any CustomerListProtocol) {
        self._anyCustomerList = anyCustomerList
        
        // Observe changes in the wrapped object and update the properties
        anyCustomerList.customerListPublisher.sink { [weak self] newValue in
            self?.customerList = newValue
        }.store(in: &cancellables)
        
        anyCustomerList.selectedCustomerPublisher.sink { [weak self] newValue in
            self?.selectedCustomer = newValue
        }.store(in: &cancellables)
        
        anyCustomerList.selectedPackedItemPublisher.sink { [weak self] newValue in
            self?.selectedPackedItem = newValue
        }.store(in: &cancellables)
        
        anyCustomerList.errorMessagePublisher.sink { [weak self] newValue in
            self?.errorMessage = newValue
        }.store(in: &cancellables)
    }
    
    func getDisplayedCustomerData() -> [Customer] {
        _anyCustomerList.getDisplayedCustomerData()
    }
    
    func addRandomCustomer() {
        _anyCustomerList.addRandomCustomer()
    }
    
    func removeCustomer(_ id: UUID) {
        _anyCustomerList.removeCustomer(id)
    }
    
    func sellPackedItem(customer: Customer, appCoordinator: any AppCoordinatorProtocol, updatePackedItemFrom: any PackedItemSellable, addBalanceTo: any BalanceUpdatable, statistics: AnyGameStatistics) {
        _anyCustomerList.sellPackedItem(customer: customer, appCoordinator: appCoordinator, updatePackedItemFrom: updatePackedItemFrom, addBalanceTo: addBalanceTo, statistics: statistics)
    }
    
    func set(activeCustomer: Customer) {
        _anyCustomerList.set(activeCustomer: activeCustomer)
    }
    
    func set(packedItem: PackedItem, coordinator: any AppCoordinatorProtocol, updatePackedItemFrom finishedPackedItemList: FinishedPackedItemListViewModel, addBalanceTo gameState: GameState, statistics: AnyGameStatistics)  {
        _anyCustomerList.set(packedItem: packedItem, coordinator: coordinator, updatePackedItemFrom: finishedPackedItemList, addBalanceTo: gameState, statistics: statistics)
    }
    
    func unsetData() {
        _anyCustomerList.unsetData()
    }
    
    
}


