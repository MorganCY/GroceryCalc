//
//  ItemCellTableViewCell.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/20.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 10
        bgView.dropShadow(opacity: 0.05)
    }

    func layoutCell(viewModel: ItemCellViewModel) {
        itemNameLabel.text = viewModel.itemName
        totalPriceLabel.text = String(viewModel.totalPrice)
    }
}
