//
//  StatCardView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class StatCardView: UIControl {

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .serif(28)
        label.textColor = .green1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override var isHighlighted: Bool {
        didSet { alpha = isHighlighted ? 0.7 : 1 }
    }

    init(caption: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.line.cgColor
        captionLabel.text = caption
        addSubview(countLabel)
        addSubview(captionLabel)
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),

            captionLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor),
            captionLabel.leadingAnchor.constraint(equalTo: countLabel.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: countLabel.trailingAnchor),
            captionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
}
