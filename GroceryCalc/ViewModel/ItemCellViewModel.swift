//
//  ItemCellViewModel.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/27.
//

import Foundation

class ItemCellViewModel {
    var id: String
    var itemName: String
    var totalPrice: Int

    init(id: String, itemName: String, totalPrice: Int) {
        self.id = id
        self.itemName = itemName
        self.totalPrice = totalPrice
    }
}
