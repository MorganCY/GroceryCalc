//
//  ViewController.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/20.
//

import UIKit

class ItemListViewController: UIViewController {

    let totalPriceView = UIView().with {
        $0.backgroundColor = ._e47c58
        $0.setCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
    }
    let totalPriceLabel = UILabel().with {
        $0.textAlignment = .center
    }
    let clearAllButton = UIButton()
    let tableView = UITableView()
    let addItemPanelView = AddItemPanelView()
    let emojiView = EmojiView()
    let hintLabel = UILabel().with {
        $0.text = "No Item to Display"
        $0.textColor = ._e47c58
        $0.font = UIFont.setFont(16, font: .regular)
    }
    var isHintDisplayed = false {
        didSet {
            hintLabel.isHidden = !isHintDisplayed
        }
    }
    var isEmojiViewDisplayed = false {
        didSet {
            emojiView.isHidden = !isEmojiViewDisplayed
        }
    }
    let viewModel = ItemListViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ._f7f6fb
        bindViewModel()
        viewModel.fetchAllItems()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }

    func bindViewModel() {
        viewModel.onRequestEnd = { [weak self] totalPrice in
            DispatchQueue.main.async {
                self?.isHintDisplayed = false
                self?.setupTotalPrice(totalPrice: totalPrice)
                self?.tableView.reloadData()
            }
        }
        viewModel.emptyRequestHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.isHintDisplayed = true
            }
        }
    }

    private func setupUI() {
        setupTotalPrice(totalPrice: viewModel.totalPrice)

        totalPriceView.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
            ])
        }

        totalPriceLabel.do {
            totalPriceView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: totalPriceView.centerXAnchor),
                $0.bottomAnchor.constraint(equalTo: totalPriceView.bottomAnchor, constant: -10),
                $0.widthAnchor.constraint(equalTo: totalPriceView.widthAnchor, multiplier: 0.5)
            ])
        }

        clearAllButton.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: totalPriceLabel.centerYAnchor),
                $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
                $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08),
                $0.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08)
            ])
            $0.tintColor = ._ffffff
            $0.imageView?.contentMode = .scaleToFill
            $0.setBackgroundImage(UIImage(systemName: "trash"), for: .init())
            $0.addTarget(self, action: #selector(clearAllButtonDidTap(_:)), for: .touchUpInside)
        }

        addItemPanelView.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = self
            addItemPanelView.layoutPosition()
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
                $0.bottomAnchor.constraint(equalTo: addItemPanelView.topAnchor, constant: -20)
            ])
            $0.backgroundColor = .clear
            $0.registerCellWithNib(identifier: ItemCell.identifier, bundle: nil)
            $0.separatorStyle = .none
        }

        hintLabel.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.center = tableView.center
            $0.isHidden = !isHintDisplayed
        }

        emojiView.do {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layoutPosition()
            $0.isHidden = !isEmojiViewDisplayed
            $0.delegate = self
        }
    }

    private func setupTotalPrice(totalPrice: Int) {
        let attributedString = NSMutableAttributedString(string: "")
        let amountAttributedString = NSAttributedString(string: "$\(totalPrice)",
                                                        attributes: [.font: UIFont.setFont(40, font: .bold),
                                                                     .foregroundColor: UIColor._ffffff])
        attributedString.append(NSAttributedString(string: "  "))
        attributedString.append(amountAttributedString)
        totalPriceLabel.attributedText = attributedString
    }

    @objc
    func clearAllButtonDidTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sure to clear all?", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Clear", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteAllItems()
        }
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ItemListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath)
        guard let cell = cell as? ItemCell else {
            return cell
        }
        let viewModel = viewModel.itemCellViewModels[indexPath.row]
        cell.hideSelectionStyle()
        cell.layoutCell(viewModel: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
            guard let id = self?.viewModel.itemCellViewModels[indexPath.row].id else {
                return
            }
            self?.viewModel.deleteItem(id: id)
        }
        deleteAction.image = UIImage(systemName: "trash")
        let trailingSwipAction = UISwipeActionsConfiguration(actions: [deleteAction])
        return trailingSwipAction
    }
}

extension ItemListViewController: AddItemPanelViewDelegate {
    func addItemPanelView(_ addItemPanelView: AddItemPanelView, addButtonDidTap item: ItemEntity) {
        viewModel.addNewItem(item: item)
    }

    func willShowEmojiView(_ addItemPanelView: AddItemPanelView) {
        isEmojiViewDisplayed = true
    }
}

extension ItemListViewController: EmojiViewDelegate {
    func emojiView(_ EmojiView: EmojiView, didSelectEmoji emoji: String) {
        addItemPanelView.emojiButton.setTitle(emoji, for: .normal)
        isEmojiViewDisplayed = false
    }

    func willHideEmojiView(_ emojiView: EmojiView) {
        isEmojiViewDisplayed = false
    }
}
