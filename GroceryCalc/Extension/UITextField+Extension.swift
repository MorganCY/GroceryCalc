//
//  UITextField+Extension.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/28.
//

import UIKit

extension UITextField {
    // Reference: https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
