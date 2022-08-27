//
//  UIColor+Extension.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/17.
//

import UIKit

enum Colors: String {
    case _ffffff
    case _e47c58
    case _f7f6fb
    case _dddfe3
}

extension UIColor {
    static let _ffffff = UIColor(._ffffff)
    static let _e47c58 = UIColor(._e47c58)
    static let _f7f6fb = UIColor(._f7f6fb)
    static let _dddfe3 = UIColor(._dddfe3)

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
