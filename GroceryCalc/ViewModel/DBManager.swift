//
//  DBManager.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/21.
//

import Foundation
import RealmSwift

class DBManager {
    var realm: Realm? = nil

    init(tableName: String) {
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL?.deleteLastPathComponent()
        config.fileURL?.appendPathComponent(tableName)
        config.fileURL?.appendPathExtension("realm")
        do {
            realm = try Realm(configuration: config)
            log("Realm DB URL: \(config.fileURL?.absoluteString ?? "")")
        } catch {
            log("Can't create Realm")
            fatalError("Can't create Realm")
        }
    }

    func write(item entity: Object) {
        do {
            try realm?.write {
                realm?.add(entity)
            }
        } catch {
            log("Can't add entity", from: (file: #file, function: #function, line: #line))
            fatalError("Can't add entity")
        }
    }

    func fetchAll<Element>(type entityType: Element.Type) -> Results<Element>? where Element: RealmFetchable {
        realm?.objects(Element.self)
    }

    func deleteEntity(id entityId: String) {
        guard let realm = realm else {
            return
        }

        do {
            try realm.write {
                let item = realm.objects(ItemEntity.self).where {
                    $0.id == entityId
                }
                realm.delete(item)
            }
        } catch {
            log("Can't delete entity", from: (file: #file, function: #function, line: #line))
            fatalError("Can't delete entity")
        }
    }

    func deleteAllItems() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            log("Can't delete all", from: (file: #file, function: #function, line: #line))
            fatalError("Can't delete all")
        }
    }
}
