//
//  ItemListViewControllerViewModel.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/27.
//

import Foundation
import RealmSwift

class ItemListViewControllerViewModel {
    let dbManager = DBManager(tableName: "itemListsss")
    var itemCellViewModels: [ItemCellViewModel] = []
    var totalPrice: Int = 0
    var onRequestEnd: ((Int) -> Void)?
    var emptyRequestHandler: (() -> Void)?

    func fetchAllItems() {
        guard let items = dbManager.fetchAll(type: ItemEntity.self) else {
            return
        }
        if items.isNotEmpty {
            convertToItemCellViewModel(items: items.map { $0 })
        } else {
            emptyRequestHandler?()
        }
    }

    func addNewItem(item: ItemEntity) {
        dbManager.write(item: item)
        convertToItemCellViewModel(items: [item])
    }

    func deleteAllItems() {
        dbManager.deleteAllItems()
        removeItemCellViewModels()
        emptyRequestHandler?()
    }

    func deleteItem(id: String) {
        dbManager.deleteEntity(id: id)
        removeItemCellViewModel(id: id)
    }

    private func convertToItemCellViewModel(items: [ItemEntity]) {
        for item in items {
            let itemCellViewModel = ItemCellViewModel(id: item.id,
                                                      emoji: item.emoji,
                                                      itemName: item.name,
                                                      totalPrice: item.price)
            itemCellViewModels.append(itemCellViewModel)
            totalPrice += item.price
        }
        onRequestEnd?(totalPrice)
    }

    private func removeItemCellViewModel(id: String) {
        guard let itemIndex = itemCellViewModels.firstIndex(where: { $0.id == id }) else {
            emptyRequestHandler?()
            return
        }
        totalPrice -= itemCellViewModels[itemIndex].price
        itemCellViewModels.remove(at: itemIndex)
        onRequestEnd?(totalPrice)
        if itemCellViewModels.count == 0 {
            emptyRequestHandler?()
        }
    }

    private func removeItemCellViewModels() {
        itemCellViewModels.removeAll()
        totalPrice = 0
        onRequestEnd?(totalPrice)
    }
}
