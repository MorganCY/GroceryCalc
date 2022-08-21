//
//  UIColor+Extension.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/17.
//

import UIKit

enum Colors: String {
    case _ffffff
    case _312b46
}

extension UIColor {
    static let _ffffff = UIColor(._ffffff)
    static let _312b46 = UIColor(._312b46)

    convenience init(_ color: Colors) {
        let rawValue = color.rawValue.replacingOccurrences(of: "_", with: "")
        guard let hexValue = Int(rawValue, radix: 16) else {
            fatalError("Invalid hex value")
        }
        self.init(red: CGFloat(hexValue >> 16 & 0xFF) / 255,
                  green: CGFloat(hexValue >> 8 & 0xFF) / 255,
                  blue: CGFloat(hexValue & 0xFF) / 255,
                  alpha: 1.0)
    }
}
