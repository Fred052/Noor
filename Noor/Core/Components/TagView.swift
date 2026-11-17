//
//  TagView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class TagView: UIView {

    enum Style { case gold, outline }

    private let style: Style

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        switch style {
        case .gold:
            backgroundColor = .gold
        case .outline:
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = UIColor.line.cgColor
        }
        addSubview(label)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 22),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setText(_ text: String) {
        let color: UIColor = style == .gold ? .goldText : .muted
        label.attributedText = NSAttributedString(string: text.uppercased(), attributes: [
            .font: UIFont.systemFont(ofSize: 11, weight: .semibold),
            .foregroundColor: color,
            .kern: 0.44
        ])
    }
}
