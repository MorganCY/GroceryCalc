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

    func dropShadow(opacity: Float = 0.3, width: Int = 4, height: Int = 4, radius: CGFloat = 8, isPath: Bool = true) {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        if isPath { layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath }
    }
}
