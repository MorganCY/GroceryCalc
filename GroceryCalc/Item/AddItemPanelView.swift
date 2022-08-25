//
//  AddItemPanelView.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/25.
//

import UIKit

protocol AddItemPanelViewDelegate: AnyObject {
    func addItemPanelView(_ addItemPanelView: AddItemPanelView, addButtonDidTap item: ItemEntity)
}

class AddItemPanelView: UIView {
    let nameTextField = UITextField().with {
        $0.placeholder = "Item name"
        $0.font = .setFont(16, font: .regular)
        $0.keyboardType = .default
        $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        $0.backgroundColor = ._ffffff
        $0.borderStyle = .roundedRect
    }
    let priceTextField = UITextField().with {
        $0.placeholder = "Item price"
        $0.font = .setFont(16, font: .regular)
        $0.keyboardType = .numberPad
        $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        $0.backgroundColor = ._ffffff
        $0.borderStyle = .roundedRect
    }
    let addButton = UIButton().with {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = ._312b46
    }

    weak var delegate: AddItemPanelViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ._312b46.withAlphaComponent(0.5)
        nameTextField.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
                $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
            ])
        }
        priceTextField.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: nameTextField.topAnchor),
                $0.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 16),
                $0.widthAnchor.constraint(equalTo: nameTextField.widthAnchor)
            ])
        }
        addButton.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: priceTextField.trailingAnchor, constant: 16),
                $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12),
                $0.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12),
                $0.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor)
            ])
            $0.addTarget(self, action: #selector(addItemButtonDidTap(_:)), for: .touchUpInside)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.layer.cornerRadius = addButton.frame.width / 2
    }

    @objc
    func addItemButtonDidTap(_ sender: UIButton) {
        let item = ItemEntity()
        item.name = nameTextField.text ?? ""
        item.price = Int(priceTextField.text ?? "0") ?? 0
        delegate?.addItemPanelView(self, addButtonDidTap: item)
    }

    func layoutPosition() {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.15)
        ])
    }
}
