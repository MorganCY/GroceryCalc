//
//  ItemCellViewModel.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/27.
//

import Foundation

class ItemCellViewModel {
    var id: String
    var emoji: String
    var itemName: String
    var price: Int

    init(id: String, emoji: String, itemName: String, totalPrice: Int) {
        self.id = id
        self.emoji = emoji
        self.itemName = itemName
        self.price = totalPrice
    }
}
