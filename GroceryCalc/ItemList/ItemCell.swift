//
//  ItemCellTableViewCell.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/20.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        emojiLabel.do {
            $0.font = .setFont(18, font: .regular)
        }
        itemNameLabel.do {
            $0.font = .setFont(18, font: .regular)
            $0.textColor = .black
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = 10
        bgView.dropShadow(opacity: 0.05)
    }

    func layoutCell(viewModel: ItemCellViewModel) {
        emojiLabel.text = viewModel.emoji
        itemNameLabel.text = viewModel.itemName
        priceLabel.attributedText = NSAttributedString(string: "$\(viewModel.price)",
                                                       attributes: [.font: UIFont.setFont(18, font: .bold),
                                                                    .foregroundColor: UIColor.gray])
    }
}
