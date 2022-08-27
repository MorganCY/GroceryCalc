//
//  EmojiView.swift
//  GroceryCalc
//
//  Created by Zheng-Yuan Yu on 2022/8/27.
//

import UIKit

protocol EmojiViewDelegate: AnyObject {
    func emojiView(_ emojiView: EmojiView, didSelectEmoji emoji: String)
    func willHideEmojiView(_ emojiView: EmojiView)
}

class EmojiView: UIView {
    let bgView = UIView().with {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    let panelView = UIView().with {
        $0.backgroundColor = ._ffffff
    }
    var collectionView: UICollectionView?
    var emojis: [String] = []
    weak var delegate: EmojiViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        emojis = getEmojis()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        panelView.layer.cornerRadius = 20
        panelView.center = center
        setupUI()
    }

    func setupUI() {
        bgView.do {
            let tapBackgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewDidTap(_:)))
            $0.addGestureRecognizer(tapBackgroundGesture)
            $0.isUserInteractionEnabled = true
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        panelView.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: centerYAnchor),
                $0.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
                $0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
            ])
        }
        collectionView = UICollectionView(frame: panelView.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.do {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.dataSource = self
            $0.delegate = self
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: panelView.topAnchor),
                $0.leadingAnchor.constraint(equalTo: panelView.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: panelView.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: panelView.bottomAnchor)
            ])
            $0.register(EmojiViewCell.self, forCellWithReuseIdentifier: String(describing: EmojiViewCell.self))
            $0.backgroundColor = .clear
        }
    }

    func layoutPosition() {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }

    @objc func backgroundViewDidTap(_ sender: UITapGestureRecognizer) {
        delegate?.willHideEmojiView(self)
    }

    func getEmojis() -> [String] {
        let emojiRanges = [
            0x1F601...0x1F64F
//            0x2702...0x27B0
//            0x1F680...0x1F6C0,
//            0x1F170...0x1F251
        ]
        var emojiStrings: [String] = []
        for range in emojiRanges {
            for emoji in range {
                guard let emojiCode = UnicodeScalar(emoji) else {
                    continue
                }
                let emojiString = String(UnicodeScalar(emojiCode))
                emojiStrings.append(emojiString)
            }
        }
        return emojiStrings
    }
}

extension EmojiView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emojis.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmojiViewCell.self), for: indexPath)
        guard let cell = cell as? EmojiViewCell else {
            return cell
        }
        cell.layoutcell(emoji: emojis[indexPath.item])
        return cell
    }
}

extension EmojiView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.emojiView(self, didSelectEmoji: emojis[indexPath.item])
    }
}

extension EmojiView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: panelView.frame.width * 0.2, height: panelView.frame.width * 0.2)
    }
}
