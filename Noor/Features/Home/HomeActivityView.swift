//
//  HomeActivityView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class HomeActivityView: UIView {

    var onNextStepTap: (() -> Void)?

    private lazy var recentLabel: UILabel = {
        let label = UILabel()
        label.setSpacedText("Recent activity", size: 13, kern: 0.78)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var recentList: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.line.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var firstRow = ActivityRowView()
    private lazy var secondRow = ActivityRowView()
    private lazy var thirdRow = ActivityRowView()

    private lazy var nextLabel: UILabel = {
        let label = UILabel()
        label.setSpacedText("A next step for you", size: 13, kern: 0.78)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextCard: UIView = {
        let view = UIView()
        view.backgroundColor = .sage
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nextTile: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nextIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "iconBulb")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .green1
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nextTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .ink
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .ink
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .green1
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
        config.background.backgroundColor = .white
        config.background.strokeColor = .line
        config.background.strokeWidth = 1
        config.background.cornerRadius = 14
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
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

    func configure(activities: [ActivityItem], nextStep: NextStep) {
        if activities.indices.contains(0) {
            firstRow.configure(item: activities[0], showsSeparator: true)
        }
        if activities.indices.contains(1) {
            secondRow.configure(item: activities[1], showsSeparator: true)
        }
        if activities.indices.contains(2) {
            thirdRow.configure(item: activities[2], showsSeparator: false)
        }

        nextTitleLabel.text = nextStep.title
        nextSubtitleLabel.text = nextStep.subtitle
        var config = nextButton.configuration
        config?.attributedTitle = AttributedString(nextStep.buttonTitle, attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]))
        nextButton.configuration = config
    }

    private func configureUI() {
        addSubview(recentLabel)
        addSubview(recentList)
        addSubview(nextLabel)
        addSubview(nextCard)

        recentList.addSubview(firstRow)
        recentList.addSubview(secondRow)
        recentList.addSubview(thirdRow)

        nextCard.addSubview(nextTile)
        nextCard.addSubview(nextTitleLabel)
        nextCard.addSubview(nextSubtitleLabel)
        nextCard.addSubview(nextButton)

        nextTile.addSubview(nextIconView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            recentLabel.topAnchor.constraint(equalTo: topAnchor),
            recentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            recentList.topAnchor.constraint(equalTo: recentLabel.bottomAnchor, constant: 8),
            recentList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            recentList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            firstRow.topAnchor.constraint(equalTo: recentList.topAnchor),
            firstRow.leadingAnchor.constraint(equalTo: recentList.leadingAnchor),
            firstRow.trailingAnchor.constraint(equalTo: recentList.trailingAnchor),

            secondRow.topAnchor.constraint(equalTo: firstRow.bottomAnchor),
            secondRow.leadingAnchor.constraint(equalTo: recentList.leadingAnchor),
            secondRow.trailingAnchor.constraint(equalTo: recentList.trailingAnchor),

            thirdRow.topAnchor.constraint(equalTo: secondRow.bottomAnchor),
            thirdRow.leadingAnchor.constraint(equalTo: recentList.leadingAnchor),
            thirdRow.trailingAnchor.constraint(equalTo: recentList.trailingAnchor),
            thirdRow.bottomAnchor.constraint(equalTo: recentList.bottomAnchor),

            nextLabel.topAnchor.constraint(equalTo: recentList.bottomAnchor, constant: 24),
            nextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            nextCard.topAnchor.constraint(equalTo: nextLabel.bottomAnchor, constant: 8),
            nextCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextCard.bottomAnchor.constraint(equalTo: bottomAnchor),

            nextTile.topAnchor.constraint(equalTo: nextCard.topAnchor, constant: 16),
            nextTile.leadingAnchor.constraint(equalTo: nextCard.leadingAnchor, constant: 16),
            nextTile.widthAnchor.constraint(equalToConstant: 44),
            nextTile.heightAnchor.constraint(equalToConstant: 44),

            nextIconView.centerXAnchor.constraint(equalTo: nextTile.centerXAnchor),
            nextIconView.centerYAnchor.constraint(equalTo: nextTile.centerYAnchor),
            nextIconView.widthAnchor.constraint(equalToConstant: 22),
            nextIconView.heightAnchor.constraint(equalToConstant: 22),

            nextTitleLabel.topAnchor.constraint(equalTo: nextCard.topAnchor, constant: 16),
            nextTitleLabel.leadingAnchor.constraint(equalTo: nextTile.trailingAnchor, constant: 12),
            nextTitleLabel.trailingAnchor.constraint(equalTo: nextCard.trailingAnchor, constant: -16),

            nextSubtitleLabel.topAnchor.constraint(equalTo: nextTitleLabel.bottomAnchor, constant: 4),
            nextSubtitleLabel.leadingAnchor.constraint(equalTo: nextTitleLabel.leadingAnchor),
            nextSubtitleLabel.trailingAnchor.constraint(equalTo: nextTitleLabel.trailingAnchor),

            nextButton.topAnchor.constraint(equalTo: nextSubtitleLabel.bottomAnchor, constant: 12),
            nextButton.leadingAnchor.constraint(equalTo: nextCard.leadingAnchor, constant: 16),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.bottomAnchor.constraint(equalTo: nextCard.bottomAnchor, constant: -16)
        ])
    }

    @objc private func nextTapped() {
        onNextStepTap?()
    }
}
