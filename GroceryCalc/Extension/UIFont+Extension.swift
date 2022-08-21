//
//  UIFont+Extension.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/17.
//

import UIKit

extension UIFont {
    enum FontType: String {
        case regular = "PingfangTC-Regular"
        case bold = "PingfangTC-Semibold"
    }

    static func setFont(_ fontSize: CGFloat, font: FontType) -> UIFont {
        return UIFont(name: font.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: 24)
    }
}
