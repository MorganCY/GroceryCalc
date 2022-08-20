//
//  UIView+Extension.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/20.
//

import UIKit

extension UIView {
    func setCorner(radius: CGFloat, corners: UIRectCorner) {
        self.layer.cornerRadius = radius
        var arr: CACornerMask = []
        let allCorners: [UIRectCorner] = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        for corner in allCorners {
            if corners.contains(corner) {
                switch corner {
                case .topLeft:
                    arr.insert(.layerMinXMinYCorner)
                case .topRight:
                    arr.insert(.layerMaxXMinYCorner)
                case .bottomLeft:
                    arr.insert(.layerMinXMaxYCorner)
                case .bottomRight:
                    arr.insert(.layerMaxXMaxYCorner)
                default: break
                }
            }
        }
        self.layer.maskedCorners = arr
    }
}
