//
//  ProfileAccountView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class ProfileAccountView: UIView {

    var onSettingsTap: (() -> Void)?
    var onPrivacyTap: (() -> Void)?
    var onHelpTap: (() -> Void)?

    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.setSpacedText("Account", size: 13, kern: 0.78)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var accountList: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.line.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var settingsRow: ProfileRowView = {
        let row = ProfileRowView(title: "Settings")
        row.configure(value: nil, showsSeparator: true)
        row.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return row
    }()

    private lazy var privacyRow: ProfileRowView = {
        let row = ProfileRowView(title: "Privacy and account")
        row.configure(value: nil, showsSeparator: true)
        row.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        return row
    }()

    private lazy var helpRow: ProfileRowView = {
        let row = ProfileRowView(title: "Help and support")
        row.configure(value: nil, showsSeparator: false)
        row.addTarget(self, action: #selector(helpTapped), for: .touchUpInside)
        return row
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(accountLabel)
        addSubview(accountList)

        accountList.addSubview(settingsRow)
        accountList.addSubview(privacyRow)
        accountList.addSubview(helpRow)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            accountLabel.topAnchor.constraint(equalTo: topAnchor),
            accountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            accountList.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 8),
            accountList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accountList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            accountList.bottomAnchor.constraint(equalTo: bottomAnchor),

            settingsRow.topAnchor.constraint(equalTo: accountList.topAnchor),
            settingsRow.leadingAnchor.constraint(equalTo: accountList.leadingAnchor),
            settingsRow.trailingAnchor.constraint(equalTo: accountList.trailingAnchor),

            privacyRow.topAnchor.constraint(equalTo: settingsRow.bottomAnchor),
            privacyRow.leadingAnchor.constraint(equalTo: accountList.leadingAnchor),
            privacyRow.trailingAnchor.constraint(equalTo: accountList.trailingAnchor),

            helpRow.topAnchor.constraint(equalTo: privacyRow.bottomAnchor),
            helpRow.leadingAnchor.constraint(equalTo: accountList.leadingAnchor),
            helpRow.trailingAnchor.constraint(equalTo: accountList.trailingAnchor),
            helpRow.bottomAnchor.constraint(equalTo: accountList.bottomAnchor)
        ])
    }

    @objc private func settingsTapped() {
        onSettingsTap?()
    }
    
    @objc private func privacyTapped() {
        onPrivacyTap?()
    }
    
    @objc private func helpTapped() {
        onHelpTap?()
    }
}
