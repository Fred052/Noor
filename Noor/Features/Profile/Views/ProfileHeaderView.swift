//
//  ProfileHeaderView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class ProfileHeaderView: UIView {

    var onSettingsTap: (() -> Void)?
    var onCreateAccountTap: (() -> Void)?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = .serif(34)
        label.textColor = .green1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: "iconSettings")
        button.setImage(icon, for: .normal)
        button.tintColor = .ink
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.line.cgColor
        button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var accountCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.line.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = .green1
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.font = .serif(26)
        label.textColor = .ivory
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .serif(22)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var guestTag: TagView = {
        let tag = TagView(style: .outline)
        tag.setText("Guest mode")
        return tag
    }()

    private lazy var deviceLabel: UILabel = {
        let label = UILabel()
        label.text = "Everything stays on this device."
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Creating an account is optional. It only adds syncing across your devices."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .muted
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create a free account", for: .normal)
        button.setTitleColor(.green1, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.line.cgColor
        button.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(userName: String, avatarLetter: String) {
        nameLabel.text = userName
        avatarLabel.text = avatarLetter
    }

    private func configureUI() {
        addSubview(titleLabel)
        addSubview(settingsButton)
        addSubview(accountCard)

        accountCard.addSubview(avatarView)
        accountCard.addSubview(nameLabel)
        accountCard.addSubview(guestTag)
        accountCard.addSubview(deviceLabel)
        accountCard.addSubview(descriptionLabel)
        accountCard.addSubview(createAccountButton)

        avatarView.addSubview(avatarLabel)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            settingsButton.widthAnchor.constraint(equalToConstant: 44),
            settingsButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerYAnchor.constraint(equalTo: settingsButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            accountCard.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            accountCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accountCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            accountCard.bottomAnchor.constraint(equalTo: bottomAnchor),

            avatarView.topAnchor.constraint(equalTo: accountCard.topAnchor, constant: 16),
            avatarView.leadingAnchor.constraint(equalTo: accountCard.leadingAnchor, constant: 16),
            avatarView.widthAnchor.constraint(equalToConstant: 60),
            avatarView.heightAnchor.constraint(equalToConstant: 60),

            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            deviceLabel.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -4),
            deviceLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            deviceLabel.trailingAnchor.constraint(equalTo: accountCard.trailingAnchor, constant: -16),

            nameLabel.bottomAnchor.constraint(equalTo: deviceLabel.topAnchor, constant: -4),
            nameLabel.leadingAnchor.constraint(equalTo: deviceLabel.leadingAnchor),

            guestTag.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            guestTag.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),

            descriptionLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: accountCard.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: accountCard.trailingAnchor, constant: -16),

            createAccountButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            createAccountButton.leadingAnchor.constraint(equalTo: accountCard.leadingAnchor, constant: 16),
            createAccountButton.trailingAnchor.constraint(equalTo: accountCard.trailingAnchor, constant: -16),
            createAccountButton.heightAnchor.constraint(equalToConstant: 48),
            createAccountButton.bottomAnchor.constraint(equalTo: accountCard.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func settingsTapped() {
        onSettingsTap?()
    }
    
    @objc private func createAccountTapped() {
        onCreateAccountTap?()
    }
}
