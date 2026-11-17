//
//  ProfileSavedView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class ProfileSavedView: UIView {

    var onBookmarksTap: (() -> Void)?
    var onNotesTap: (() -> Void)?
    var onDownloadsTap: (() -> Void)?
    var onPremiumTap: (() -> Void)?

    private lazy var savedLabel: UILabel = {
        let label = UILabel()
        label.setSpacedText("Saved content", size: 13, kern: 0.78)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bookmarksCard: StatCardView = {
        let card = StatCardView(caption: "Bookmarks")
        card.addTarget(self, action: #selector(bookmarksTapped), for: .touchUpInside)
        return card
    }()

    private lazy var notesCard: StatCardView = {
        let card = StatCardView(caption: "Notes")
        card.addTarget(self, action: #selector(notesTapped), for: .touchUpInside)
        return card
    }()

    private lazy var downloadsCard: StatCardView = {
        let card = StatCardView(caption: "Downloads")
        card.addTarget(self, action: #selector(downloadsTapped), for: .touchUpInside)
        return card
    }()

    private lazy var subscriptionLabel: UILabel = {
        let label = UILabel()
        label.setSpacedText("Subscription", size: 13, kern: 0.78)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subscriptionCard: UIView = {
        let view = UIView()
        view.backgroundColor = .sage
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var planLabel: UILabel = {
        let label = UILabel()
        label.text = "NUR Free"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var planCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "The full Quran stays free, always."
        label.font = .systemFont(ofSize: 13)
        label.textColor = .ink
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var premiumButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See Premium", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .green1
        button.layer.cornerRadius = 14
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        button.addTarget(self, action: #selector(premiumTapped), for: .touchUpInside)
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

    func configure(summary: ProfileSummary) {
        bookmarksCard.setCount(summary.bookmarks)
        notesCard.setCount(summary.notes)
        downloadsCard.setCount(summary.downloads)
    }

    private func configureUI() {
        addSubview(savedLabel)
        addSubview(bookmarksCard)
        addSubview(notesCard)
        addSubview(downloadsCard)
        addSubview(subscriptionLabel)
        addSubview(subscriptionCard)

        subscriptionCard.addSubview(planLabel)
        subscriptionCard.addSubview(planCaptionLabel)
        subscriptionCard.addSubview(premiumButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            savedLabel.topAnchor.constraint(equalTo: topAnchor),
            savedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            bookmarksCard.topAnchor.constraint(equalTo: savedLabel.bottomAnchor, constant: 8),
            bookmarksCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            notesCard.topAnchor.constraint(equalTo: bookmarksCard.topAnchor),
            notesCard.leadingAnchor.constraint(equalTo: bookmarksCard.trailingAnchor, constant: 8),
            notesCard.widthAnchor.constraint(equalTo: bookmarksCard.widthAnchor),

            downloadsCard.topAnchor.constraint(equalTo: bookmarksCard.topAnchor),
            downloadsCard.leadingAnchor.constraint(equalTo: notesCard.trailingAnchor, constant: 8),
            downloadsCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            downloadsCard.widthAnchor.constraint(equalTo: bookmarksCard.widthAnchor),

            subscriptionLabel.topAnchor.constraint(equalTo: bookmarksCard.bottomAnchor, constant: 20),
            subscriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            subscriptionCard.topAnchor.constraint(equalTo: subscriptionLabel.bottomAnchor, constant: 8),
            subscriptionCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subscriptionCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subscriptionCard.bottomAnchor.constraint(equalTo: bottomAnchor),

            premiumButton.trailingAnchor.constraint(equalTo: subscriptionCard.trailingAnchor, constant: -16),
            premiumButton.centerYAnchor.constraint(equalTo: subscriptionCard.centerYAnchor),
            premiumButton.heightAnchor.constraint(equalToConstant: 40),

            planLabel.topAnchor.constraint(equalTo: subscriptionCard.topAnchor, constant: 16),
            planLabel.leadingAnchor.constraint(equalTo: subscriptionCard.leadingAnchor, constant: 16),
            planLabel.trailingAnchor.constraint(equalTo: premiumButton.leadingAnchor, constant: -12),

            planCaptionLabel.topAnchor.constraint(equalTo: planLabel.bottomAnchor, constant: 2),
            planCaptionLabel.leadingAnchor.constraint(equalTo: planLabel.leadingAnchor),
            planCaptionLabel.trailingAnchor.constraint(equalTo: planLabel.trailingAnchor),
            planCaptionLabel.bottomAnchor.constraint(equalTo: subscriptionCard.bottomAnchor, constant: -16)
        ])
        premiumButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    @objc private func bookmarksTapped() {
        onBookmarksTap?()
    }
    
    @objc private func notesTapped() {
        onNotesTap?()
    }
    
    @objc private func downloadsTapped() {
        onDownloadsTap?()
    }
    
    @objc private func premiumTapped() {
        onPremiumTap?()
    }
}
