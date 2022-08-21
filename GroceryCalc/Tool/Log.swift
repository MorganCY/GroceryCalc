//
//  Log.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/21.
//

import Foundation

typealias LogLocation = (file: String, function: String, line: UInt)

func log(_ message: @autoclosure () -> String,
         from location: @autoclosure () -> LogLocation? = (file: #file, function: #function, line: #line)) {
    if let location = location() {
        print("\(message()), \(location)")
    } else {
        print("\(message())")
    }
}
