//
//  HomeHeaderView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class HomeHeaderView: UIView {

    var onBellTap: (() -> Void)?
    var onAvatarTap: (() -> Void)?

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "nurlogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "iconBell")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .ink
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.line.cgColor
        button.addTarget(self, action: #selector(bellTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var avatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green1
        button.setTitleColor(.ivory, for: .normal)
        button.titleLabel?.font = .serif(16)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(avatarTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = .serif(30)
        label.textColor = .green1
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(dateText: String, greetingText: String, avatarLetter: String) {
        dateLabel.text = dateText
        greetingLabel.text = greetingText
        avatarButton.setTitle(avatarLetter, for: .normal)
    }

    private func configureUI() {
        addSubview(logoImageView)
        addSubview(bellButton)
        addSubview(avatarButton)
        addSubview(dateLabel)
        addSubview(greetingLabel)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            logoImageView.widthAnchor.constraint(equalToConstant: 36),
            logoImageView.heightAnchor.constraint(equalToConstant: 36),

            avatarButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            avatarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            avatarButton.widthAnchor.constraint(equalToConstant: 44),
            avatarButton.heightAnchor.constraint(equalToConstant: 44),

            bellButton.centerYAnchor.constraint(equalTo: avatarButton.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: avatarButton.leadingAnchor, constant: -8),
            bellButton.widthAnchor.constraint(equalToConstant: 44),
            bellButton.heightAnchor.constraint(equalToConstant: 44),

            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            greetingLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            greetingLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func bellTapped() {
        onBellTap?()
    }
    
    @objc private func avatarTapped() {
        onAvatarTap?()
    }
}
