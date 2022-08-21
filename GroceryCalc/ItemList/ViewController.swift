//
//  ViewController.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/20.
//

import UIKit

class ViewController: UIViewController {

    let totalPriceLabel = UILabel()
    let saveButton = UIButton()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ._312b46
        setupUI()
    }

    private func setupUI() {
        totalPriceLabel.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
            ])
        }
        let attributedString = NSMutableAttributedString(string: "")
        let totalAttributedString = NSAttributedString(string: "Total",
                                       attributes: [.font: UIFont.setFont(20, font: .regular),
                                                    .foregroundColor: UIColor._ffffff])
        let amountAttributedString = NSAttributedString(string: "$0",
                                        attributes: [.font: UIFont.setFont(40, font: .bold),
                                                     .foregroundColor: UIColor._ffffff])
        attributedString.append(totalAttributedString)
        attributedString.append(NSAttributedString(string: "  "))
        attributedString.append(amountAttributedString)
        totalPriceLabel.attributedText = attributedString

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
                $0.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 40),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            $0.backgroundColor = ._ffffff
            $0.registerCellWithNib(identifier: ItemCell.identifier, bundle: nil)
            $0.registerFooterWithNib(identifier: AddOneFooterView.identifier, bundle: nil)
            $0.setCorner(radius: 10, corners: [.topLeft, .topRight])
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

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddOneFooterView.identifier)
        return footer
    }
}

