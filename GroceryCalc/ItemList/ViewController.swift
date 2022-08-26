//
//  ViewController.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/20.
//

import UIKit

class ViewController: UIViewController {

    let totalPriceView = UIView().with {
        $0.backgroundColor = ._e47c58
        $0.setCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
    }
    let totalPriceLabel = UILabel()
    let saveButton = UIButton()
    let tableView = UITableView()
    let addItemPanelView = AddItemPanelView()
    let dbManager = DBManager(tableName: "ItemList")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ._f7f6fb
        setupUI()
    }

    private func setupUI() {
        let attributedString = NSMutableAttributedString(string: "")
        let amountAttributedString = NSAttributedString(string: "$0",
                                        attributes: [.font: UIFont.setFont(40, font: .bold),
                                                     .foregroundColor: UIColor._ffffff])
        attributedString.append(NSAttributedString(string: "  "))
        attributedString.append(amountAttributedString)
        totalPriceLabel.attributedText = attributedString

        totalPriceView.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
            ])
        }

        totalPriceLabel.do {
            totalPriceView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: totalPriceView.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: totalPriceView.centerYAnchor, constant: 20)
            ])
        }

        saveButton.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: totalPriceLabel.centerYAnchor),
                $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
                $0.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
            ])
            $0.tintColor = ._ffffff
            $0.imageView?.contentMode = .scaleToFill
            $0.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .init())
        }

        tableView.do {
            view.addSubview($0)
            $0.dataSource = self
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: totalPriceView.bottomAnchor, constant: 20),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            $0.backgroundColor = .clear
            $0.registerCellWithNib(identifier: ItemCell.identifier, bundle: nil)
        }

        addItemPanelView.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = self
            addItemPanelView.layoutPosition()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath)
        cell.hideSelectionStyle()
        return cell
    }
}

extension ViewController: AddItemPanelViewDelegate {
    func addItemPanelView(_ addItemPanelView: AddItemPanelView, addButtonDidTap item: ItemEntity) {
        dbManager.write(item: item)
    }
}
