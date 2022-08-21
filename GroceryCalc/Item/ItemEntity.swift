//
//  ItemEntity.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/21.
//

import Foundation
import RealmSwift

class ItemEntity: Object {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var price: Int = 0
}
