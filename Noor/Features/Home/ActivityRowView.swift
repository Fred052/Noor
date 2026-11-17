//
//  ActivityRowView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class ActivityRowView: UIView {

    private lazy var tileView: UIView = {
        let view = UIView()
        view.backgroundColor = .sage
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .green1
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var chevronView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .muted
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .line
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: ActivityItem, showsSeparator: Bool) {
        iconView.image = UIImage(named: item.iconName)?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = item.title
        timeLabel.text = item.time
        separator.isHidden = !showsSeparator
    }

    private func configureConstraints() {
        addSubview(tileView)
        tileView.addSubview(iconView)
        [titleLabel, timeLabel, chevronView, separator].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),

            tileView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tileView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tileView.widthAnchor.constraint(equalToConstant: 40),
            tileView.heightAnchor.constraint(equalToConstant: 40),

            iconView.centerXAnchor.constraint(equalTo: tileView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: tileView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            titleLabel.leadingAnchor.constraint(equalTo: tileView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: chevronView.leadingAnchor, constant: -8),

            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            chevronView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chevronView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronView.widthAnchor.constraint(equalToConstant: 14),
            chevronView.heightAnchor.constraint(equalToConstant: 14),

            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
