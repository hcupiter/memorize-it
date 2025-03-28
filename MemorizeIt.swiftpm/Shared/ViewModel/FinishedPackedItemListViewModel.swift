//
//  PackedItemListViewModel.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 20/01/25.
//

import Foundation

class FinishedPackedItemListViewModel: ObservableObject, ItemPackable, PackedItemSellable {
    @Published var finishedPackedItemList: [UUID: PackedItem] = [:]
    
    var displayedPackedItem: [PackedItem] {
        Array(finishedPackedItemList.values.sorted(by: {$0.dateCreated < $1.dateCreated}))
    }
    
    @Published var selectedPackedItem: PackedItem? = nil
    
    init(finishedItem: [UUID:PackedItem]? = nil) {
        if let finishedItem = finishedItem {
            self.finishedPackedItemList = finishedItem
        }
    }
    
    func updatePackedItem(packedItem: PackedItem) {
        self.finishedPackedItemList[packedItem.id] = packedItem
    }
    
    func sellPackedItem(_ packed: PackedItem) {
        self.finishedPackedItemList.removeValue(forKey: packed.id)
    }
    
    func setPackedItem(
        _ packed: PackedItem,
        appCoordinator: AppCoordinatorProtocol,
        stockList: StockListViewModel
    ) {
        if self.selectedPackedItem != nil {
            self.selectedPackedItem = nil
        }
        else {
            self.selectedPackedItem = packed
            appCoordinator.presentSheet(
                .viewPackItemDetail(
                    packedItem: packed,
                    finishedItemList: self,
                    stockList: stockList,
                    onDismiss: {
                        self.selectedPackedItem = nil
                    }
                )
            )
        }
    }
    
    func unsetPackedItem(appCoordinator: AppCoordinatorProtocol) {
        self.selectedPackedItem = nil
        appCoordinator.dismissSheet(onDismiss: nil)
    }
    
    func unpackPackedItem(packedItem: PackedItem, appCoordinator: AppCoordinatorProtocol) {
        self.finishedPackedItemList.removeValue(forKey: packedItem.id)
        unsetPackedItem(appCoordinator: appCoordinator)
    }
    
}
