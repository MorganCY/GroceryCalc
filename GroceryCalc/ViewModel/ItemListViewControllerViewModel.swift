//
//  ItemListViewControllerViewModel.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/27.
//

import Foundation
import RealmSwift

class ItemListViewControllerViewModel {
    let dbManager = DBManager(tableName: "itemList")
    var itemCellViewModels: [ItemCellViewModel] = []
    var onRequestEnd: (() -> Void)?
    var emptyRequestHandler: (() -> Void)?

    func fetchAllItems() {
        guard let items = dbManager.fetchAll(type: ItemEntity.self) else {
            self.emptyRequestHandler?()
            return
        }
        convertToItemCellViewModel(items: items.map { $0 })
    }

    func addNewItem(item: ItemEntity) {
        dbManager.write(item: item)
        convertToItemCellViewModel(items: [item])
    }

    func deleteAllItems() {
        dbManager.deleteAllItems()
        removeItemCellViewModels()
    }

    func deleteItem(id: String) {
        dbManager.deleteEntity(id: id)
        removeItemCellViewModel(id: id)
    }

    private func convertToItemCellViewModel(items: [ItemEntity]) {
        for item in items {
            let itemCellViewModel = ItemCellViewModel(id: item.id,
                                                      itemName: item.name,
                                                      totalPrice: item.price)
            itemCellViewModels.append(itemCellViewModel)
        }
        onRequestEnd?()
    }

    private func removeItemCellViewModel(id: String) {
        guard let itemIndex = itemCellViewModels.firstIndex(where: { $0.id == id }) else {
            emptyRequestHandler?()
            return
        }
        itemCellViewModels.remove(at: itemIndex)
        onRequestEnd?()
    }

    private func removeItemCellViewModels() {
        itemCellViewModels.removeAll()
        onRequestEnd?()
    }
}
