//
//  ProfilePreferencesView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class ProfilePreferencesView: UIView {

    var onThemeTap: (() -> Void)?
    var onTranslationTap: (() -> Void)?
    var onMemorizationTap: (() -> Void)?

    private lazy var preferencesLabel: UILabel = {
        let label = UILabel()
        label.setSpacedText("Reading preferences", size: 13, kern: 0.78)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var preferencesList: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.line.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var themeRow: ProfileRowView = {
        let row = ProfileRowView(title: "Reading theme")
        row.addTarget(self, action: #selector(themeTapped), for: .touchUpInside)
        return row
    }()

    private lazy var translationRow: ProfileRowView = {
        let row = ProfileRowView(title: "Translation")
        row.addTarget(self, action: #selector(translationTapped), for: .touchUpInside)
        return row
    }()

    private lazy var memorizationLabel: UILabel = {
        let label = UILabel()
        label.setSpacedText("Memorization", size: 13, kern: 0.78)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var memorizationCard: UIControl = {
        let control = UIControl()
        control.backgroundColor = .white
        control.layer.cornerRadius = 20
        control.layer.borderWidth = 1
        control.layer.borderColor = UIColor.line.cgColor
        control.addTarget(self, action: #selector(memorizationTapped), for: .touchUpInside)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private lazy var ringView: RingView = {
        let ring = RingView()
        ring.isUserInteractionEnabled = false
        ring.translatesAutoresizingMaskIntoConstraints = false
        return ring
    }()

    private lazy var versesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextReviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var memorizationChevron: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .muted
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(summary: ProfileSummary) {
        themeRow.configure(value: summary.readingTheme, showsSeparator: true)
        translationRow.configure(value: summary.translation, showsSeparator: false)

        let percent = Int(summary.memorizationProgress * 100)
        ringView.configure(minutes: percent, progress: summary.memorizationProgress)
        versesLabel.text = "\(summary.versesMemorized) verses memorized"
        nextReviewLabel.text = summary.nextReview
    }

    private func configureUI() {
        addSubview(preferencesLabel)
        addSubview(preferencesList)
        addSubview(memorizationLabel)
        addSubview(memorizationCard)

        preferencesList.addSubview(themeRow)
        preferencesList.addSubview(translationRow)

        memorizationCard.addSubview(ringView)
        memorizationCard.addSubview(versesLabel)
        memorizationCard.addSubview(nextReviewLabel)
        memorizationCard.addSubview(memorizationChevron)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            preferencesLabel.topAnchor.constraint(equalTo: topAnchor),
            preferencesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            preferencesList.topAnchor.constraint(equalTo: preferencesLabel.bottomAnchor, constant: 8),
            preferencesList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            preferencesList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            themeRow.topAnchor.constraint(equalTo: preferencesList.topAnchor),
            themeRow.leadingAnchor.constraint(equalTo: preferencesList.leadingAnchor),
            themeRow.trailingAnchor.constraint(equalTo: preferencesList.trailingAnchor),

            translationRow.topAnchor.constraint(equalTo: themeRow.bottomAnchor),
            translationRow.leadingAnchor.constraint(equalTo: preferencesList.leadingAnchor),
            translationRow.trailingAnchor.constraint(equalTo: preferencesList.trailingAnchor),
            translationRow.bottomAnchor.constraint(equalTo: preferencesList.bottomAnchor),

            memorizationLabel.topAnchor.constraint(equalTo: preferencesList.bottomAnchor, constant: 20),
            memorizationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            memorizationCard.topAnchor.constraint(equalTo: memorizationLabel.bottomAnchor, constant: 8),
            memorizationCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            memorizationCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            memorizationCard.heightAnchor.constraint(equalToConstant: 76),
            memorizationCard.bottomAnchor.constraint(equalTo: bottomAnchor),

            ringView.leadingAnchor.constraint(equalTo: memorizationCard.leadingAnchor, constant: 16),
            ringView.centerYAnchor.constraint(equalTo: memorizationCard.centerYAnchor),
            ringView.widthAnchor.constraint(equalToConstant: 44),
            ringView.heightAnchor.constraint(equalToConstant: 44),

            memorizationChevron.trailingAnchor.constraint(equalTo: memorizationCard.trailingAnchor, constant: -16),
            memorizationChevron.centerYAnchor.constraint(equalTo: memorizationCard.centerYAnchor),
            memorizationChevron.widthAnchor.constraint(equalToConstant: 14),
            memorizationChevron.heightAnchor.constraint(equalToConstant: 14),

            nextReviewLabel.centerYAnchor.constraint(equalTo: memorizationCard.centerYAnchor, constant: 10),
            nextReviewLabel.leadingAnchor.constraint(equalTo: ringView.trailingAnchor, constant: 16),
            nextReviewLabel.trailingAnchor.constraint(equalTo: memorizationChevron.leadingAnchor, constant: -8),

            versesLabel.bottomAnchor.constraint(equalTo: nextReviewLabel.topAnchor, constant: -2),
            versesLabel.leadingAnchor.constraint(equalTo: nextReviewLabel.leadingAnchor),
            versesLabel.trailingAnchor.constraint(equalTo: nextReviewLabel.trailingAnchor)
        ])
    }

    @objc private func themeTapped() {
        onThemeTap?()
    }
    
    @objc private func translationTapped() {
        onTranslationTap?()
    }
    
    @objc private func memorizationTapped() {
        onMemorizationTap?()
    }
}
