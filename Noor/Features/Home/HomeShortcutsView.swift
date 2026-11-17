//
//  HomeShortcutsView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class HomeShortcutsView: UIView {

    var onQuickAction: ((QuickAction) -> Void)?
    var onBookmarkTap: (() -> Void)?

    private lazy var readQuranAction: QuickActionView = {
        let view = QuickActionView(iconName: "tabQuran", title: "Read Quran")
        view.addTarget(self, action: #selector(readQuranTapped), for: .touchUpInside)
        return view
    }()

    private lazy var listenAction: QuickActionView = {
        let view = QuickActionView(iconName: "iconHeadphones", title: "Listen")
        view.addTarget(self, action: #selector(listenTapped), for: .touchUpInside)
        return view
    }()

    private lazy var memorizeAction: QuickActionView = {
        let view = QuickActionView(iconName: "tabHifz", title: "Memorize")
        view.addTarget(self, action: #selector(memorizeTapped), for: .touchUpInside)
        return view
    }()

    private lazy var exploreAction: QuickActionView = {
        let view = QuickActionView(iconName: "iconBulb", title: "Explore meanings")
        view.addTarget(self, action: #selector(exploreTapped), for: .touchUpInside)
        return view
    }()

    private lazy var verseCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.line.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var verseEyebrow: UILabel = {
        let label = UILabel()
        label.setSpacedText("Verse of the day", size: 12, kern: 0.96)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "iconBookmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .green1
        button.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var arabicLabel: UILabel = {
        let label = UILabel()
        label.font = .arabic(30)
        label.textColor = .ink
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var translationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .ink
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var referenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var sampleTag: TagView = {
        let tag = TagView(style: .outline)
        tag.setText("Sample")
        return tag
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(verse: DailyVerse) {
        arabicLabel.text = verse.arabic
        translationLabel.text = verse.translation
        referenceLabel.text = verse.reference
    }

    private func configureUI() {
        addSubview(readQuranAction)
        addSubview(listenAction)
        addSubview(memorizeAction)
        addSubview(exploreAction)
        addSubview(verseCard)

        verseCard.addSubview(verseEyebrow)
        verseCard.addSubview(bookmarkButton)
        verseCard.addSubview(arabicLabel)
        verseCard.addSubview(translationLabel)
        verseCard.addSubview(referenceLabel)
        verseCard.addSubview(sampleTag)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            readQuranAction.topAnchor.constraint(equalTo: topAnchor),
            readQuranAction.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            listenAction.topAnchor.constraint(equalTo: readQuranAction.topAnchor),
            listenAction.leadingAnchor.constraint(equalTo: readQuranAction.trailingAnchor, constant: 10),
            listenAction.widthAnchor.constraint(equalTo: readQuranAction.widthAnchor),

            memorizeAction.topAnchor.constraint(equalTo: readQuranAction.topAnchor),
            memorizeAction.leadingAnchor.constraint(equalTo: listenAction.trailingAnchor, constant: 10),
            memorizeAction.widthAnchor.constraint(equalTo: readQuranAction.widthAnchor),

            exploreAction.topAnchor.constraint(equalTo: readQuranAction.topAnchor),
            exploreAction.leadingAnchor.constraint(equalTo: memorizeAction.trailingAnchor, constant: 10),
            exploreAction.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            exploreAction.widthAnchor.constraint(equalTo: readQuranAction.widthAnchor),

            verseCard.topAnchor.constraint(equalTo: readQuranAction.bottomAnchor, constant: 24),
            verseCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            verseCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            verseCard.bottomAnchor.constraint(equalTo: bottomAnchor),

            verseEyebrow.topAnchor.constraint(equalTo: verseCard.topAnchor, constant: 20),
            verseEyebrow.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 20),

            bookmarkButton.centerYAnchor.constraint(equalTo: verseEyebrow.centerYAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -12),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 44),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 44),

            arabicLabel.topAnchor.constraint(equalTo: verseEyebrow.bottomAnchor, constant: 10),
            arabicLabel.leadingAnchor.constraint(equalTo: verseCard.leadingAnchor, constant: 20),
            arabicLabel.trailingAnchor.constraint(equalTo: verseCard.trailingAnchor, constant: -20),

            translationLabel.topAnchor.constraint(equalTo: arabicLabel.bottomAnchor, constant: 10),
            translationLabel.leadingAnchor.constraint(equalTo: arabicLabel.leadingAnchor),
            translationLabel.trailingAnchor.constraint(equalTo: arabicLabel.trailingAnchor),

            referenceLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 12),
            referenceLabel.leadingAnchor.constraint(equalTo: arabicLabel.leadingAnchor),
            referenceLabel.trailingAnchor.constraint(equalTo: sampleTag.leadingAnchor, constant: -8),
            referenceLabel.bottomAnchor.constraint(equalTo: verseCard.bottomAnchor, constant: -20),

            sampleTag.centerYAnchor.constraint(equalTo: referenceLabel.centerYAnchor),
            sampleTag.trailingAnchor.constraint(equalTo: arabicLabel.trailingAnchor)
        ])
        referenceLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        sampleTag.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    @objc private func readQuranTapped() {
        onQuickAction?(.readQuran)
    }
    
    @objc private func listenTapped() {
        onQuickAction?(.listen)
    }
    
    @objc private func memorizeTapped() {
        onQuickAction?(.memorize)
    }
    
    @objc private func exploreTapped() {
        onQuickAction?(.explore)
    }
    
    @objc private func bookmarkTapped() {
        onBookmarkTap?()
    }
}
