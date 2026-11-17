//
//  HomeReadingView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class HomeReadingView: UIView {

    var onContinueTap: (() -> Void)?
    var onTodayTap: (() -> Void)?

    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "homeHero"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var continueCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.line.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var continueEyebrow: UILabel = {
        let label = UILabel()
        label.setSpacedText("Continue reading", size: 12, kern: 0.96)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pageTag: TagView = {
        let tag = TagView(style: .gold)
        return tag
    }()

    private lazy var surahLabel: UILabel = {
        let label = UILabel()
        label.font = .serif(24)
        label.textColor = .green1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var verseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .green1
        button.layer.cornerRadius = 26
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .gold
        progressView.trackTintColor = .line
        progressView.layer.cornerRadius = 2
        progressView.clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()

    private lazy var todayCard: UIControl = {
        let control = UIControl()
        control.backgroundColor = .white
        control.layer.cornerRadius = 20
        control.layer.borderWidth = 1
        control.layer.borderColor = UIColor.line.cgColor
        control.addTarget(self, action: #selector(todayTapped), for: .touchUpInside)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private lazy var ringView: RingView = {
        let ring = RingView()
        ring.isUserInteractionEnabled = false
        ring.translatesAutoresizingMaskIntoConstraints = false
        return ring
    }()

    private lazy var todayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Today’s reading"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var todaySubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var todayHintLabel: UILabel = {
        let label = UILabel()
        label.text = "Continue at your own pace."
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .green1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var todayChevron: UIImageView = {
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

    func configure(lastRead: LastRead, today: TodayReading) {
        pageTag.setText("Page \(lastRead.page)")
        surahLabel.text = lastRead.surahName
        verseLabel.text = "Verse \(lastRead.verse) of \(lastRead.totalVerses)"
        progressView.setProgress(lastRead.progress, animated: false)

        ringView.configure(minutes: today.doneMinutes, progress: today.progress)
        todaySubtitleLabel.text = "\(today.doneMinutes) of \(today.goalMinutes) minutes"
    }

    private func configureUI() {
        addSubview(heroImageView)
        addSubview(continueCard)
        addSubview(todayCard)

        continueCard.addSubview(continueEyebrow)
        continueCard.addSubview(pageTag)
        continueCard.addSubview(surahLabel)
        continueCard.addSubview(verseLabel)
        continueCard.addSubview(continueButton)
        continueCard.addSubview(progressView)

        todayCard.addSubview(ringView)
        todayCard.addSubview(todayTitleLabel)
        todayCard.addSubview(todaySubtitleLabel)
        todayCard.addSubview(todayHintLabel)
        todayCard.addSubview(todayChevron)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            heroImageView.heightAnchor.constraint(equalTo: heroImageView.widthAnchor, multiplier: 200.0 / 353.0),

            continueCard.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -52),
            continueCard.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor),
            continueCard.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor),

            continueEyebrow.topAnchor.constraint(equalTo: continueCard.topAnchor, constant: 16),
            continueEyebrow.leadingAnchor.constraint(equalTo: continueCard.leadingAnchor, constant: 16),

            pageTag.centerYAnchor.constraint(equalTo: continueEyebrow.centerYAnchor),
            pageTag.trailingAnchor.constraint(equalTo: continueCard.trailingAnchor, constant: -16),

            continueButton.topAnchor.constraint(equalTo: continueEyebrow.bottomAnchor, constant: 8),
            continueButton.trailingAnchor.constraint(equalTo: continueCard.trailingAnchor, constant: -16),
            continueButton.widthAnchor.constraint(equalToConstant: 52),
            continueButton.heightAnchor.constraint(equalToConstant: 52),

            verseLabel.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor),
            verseLabel.leadingAnchor.constraint(equalTo: continueCard.leadingAnchor, constant: 16),
            verseLabel.trailingAnchor.constraint(equalTo: continueButton.leadingAnchor, constant: -8),

            surahLabel.bottomAnchor.constraint(equalTo: verseLabel.topAnchor, constant: -4),
            surahLabel.leadingAnchor.constraint(equalTo: verseLabel.leadingAnchor),
            surahLabel.trailingAnchor.constraint(equalTo: verseLabel.trailingAnchor),

            progressView.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 12),
            progressView.leadingAnchor.constraint(equalTo: continueCard.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: continueCard.trailingAnchor, constant: -16),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            progressView.bottomAnchor.constraint(equalTo: continueCard.bottomAnchor, constant: -16),

            todayCard.topAnchor.constraint(equalTo: continueCard.bottomAnchor, constant: 16),
            todayCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            todayCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            todayCard.heightAnchor.constraint(equalToConstant: 96),
            todayCard.bottomAnchor.constraint(equalTo: bottomAnchor),

            ringView.leadingAnchor.constraint(equalTo: todayCard.leadingAnchor, constant: 16),
            ringView.centerYAnchor.constraint(equalTo: todayCard.centerYAnchor),
            ringView.widthAnchor.constraint(equalToConstant: 64),
            ringView.heightAnchor.constraint(equalToConstant: 64),

            todayChevron.trailingAnchor.constraint(equalTo: todayCard.trailingAnchor, constant: -16),
            todayChevron.centerYAnchor.constraint(equalTo: todayCard.centerYAnchor),
            todayChevron.widthAnchor.constraint(equalToConstant: 14),
            todayChevron.heightAnchor.constraint(equalToConstant: 14),

            todaySubtitleLabel.centerYAnchor.constraint(equalTo: todayCard.centerYAnchor),
            todaySubtitleLabel.leadingAnchor.constraint(equalTo: ringView.trailingAnchor, constant: 16),
            todaySubtitleLabel.trailingAnchor.constraint(equalTo: todayChevron.leadingAnchor, constant: -8),

            todayTitleLabel.bottomAnchor.constraint(equalTo: todaySubtitleLabel.topAnchor, constant: -4),
            todayTitleLabel.leadingAnchor.constraint(equalTo: todaySubtitleLabel.leadingAnchor),

            todayHintLabel.topAnchor.constraint(equalTo: todaySubtitleLabel.bottomAnchor, constant: 4),
            todayHintLabel.leadingAnchor.constraint(equalTo: todaySubtitleLabel.leadingAnchor)
        ])
    }

    @objc private func continueTapped() {
        onContinueTap?()
    }
    
    @objc private func todayTapped() {
        onTodayTap?()
    }
}
