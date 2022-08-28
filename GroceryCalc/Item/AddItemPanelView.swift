//
//  AddItemPanelView.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/25.
//

import UIKit

protocol AddItemPanelViewDelegate: AnyObject {
    func addItemPanelView(_ addItemPanelView: AddItemPanelView, addButtonDidTap item: ItemEntity)
    func willShowEmojiView(_ addItemPanelView: AddItemPanelView)
}

class AddItemPanelView: UIView {
    let emojiButton = UIButton().with {
        $0.setTitle("🐔", for: .normal)
    }
    let nameTextField = UITextField().with {
        $0.attributedPlaceholder = NSAttributedString(string: "Item name...",
                                                      attributes: [.font: UIFont.setFont(12, font: .bold),
                                                                   .foregroundColor: UIColor._bebebe])
        $0.font = .setFont(16, font: .regular)
        $0.keyboardType = .default
        $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        $0.backgroundColor = .clear
        $0.textColor = ._808080
        $0.setLeftPaddingPoints(10)
    }
    let priceTextField = UITextField().with {
        $0.attributedPlaceholder = NSAttributedString(string: "Item price...",
                                                      attributes: [.font: UIFont.setFont(12, font: .bold),
                                                                   .foregroundColor: UIColor._bebebe])
        $0.font = .setFont(16, font: .regular)
        $0.keyboardType = .numberPad
        $0.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        $0.backgroundColor = .clear
        $0.textColor = ._808080
        $0.setLeftPaddingPoints(10)
    }
    let addButton = UIButton().with {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = ._e47c58
    }

    weak var delegate: AddItemPanelViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ._ffffff
        setCorner(radius: 20, corners: [.topLeft, .topRight])
        emojiButton.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor, constant: 24),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
                $0.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1)
            ])
            $0.backgroundColor = ._dddfe3
            $0.addTarget(self, action: #selector(emojiButtonDidTap(_:)), for: .touchUpInside)
        }
        nameTextField.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = self
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: emojiButton.centerYAnchor),
                $0.leadingAnchor.constraint(equalTo: emojiButton.trailingAnchor, constant: 12),
                $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
                $0.heightAnchor.constraint(equalTo: emojiButton.heightAnchor)
            ])
        }
        priceTextField.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = self
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: emojiButton.centerYAnchor),
                $0.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 12),
                $0.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
                $0.heightAnchor.constraint(equalTo: emojiButton.heightAnchor)
            ])
        }
        addButton.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: priceTextField.trailingAnchor, constant: 12),
                $0.widthAnchor.constraint(equalTo:  emojiButton.heightAnchor),
                $0.heightAnchor.constraint(equalTo: emojiButton.heightAnchor),
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
        dropShadow(opacity: 0.15, height: -3)
        emojiButton.layer.cornerRadius = emojiButton.frame.width / 2
        nameTextField.do {
            $0.layer.borderColor = UIColor._bebebe.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 5
        }
        priceTextField.do {
            $0.layer.borderColor = UIColor._bebebe.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 5
        }
    }

    @objc
    func addItemButtonDidTap(_ sender: UIButton) {
        let item = ItemEntity()
        item.emoji = emojiButton.titleLabel?.text ?? ""
        item.name = nameTextField.text ?? ""
        item.price = Int(priceTextField.text ?? "0") ?? 0
        nameTextField.text?.removeAll()
        priceTextField.text?.removeAll()
        delegate?.addItemPanelView(self, addButtonDidTap: item)
    }

    @objc
    func emojiButtonDidTap(_ sender: UIButton) {
        delegate?.willShowEmojiView(self)
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
            heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.13)
        ])
    }
}

extension AddItemPanelView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let textLimit = textField == nameTextField ? 10 : 5
        return updatedText.count <= textLimit
    }
}
