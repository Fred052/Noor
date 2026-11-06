//
//  GoalsCell.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

class GoalCell: UICollectionViewCell {

    static let identifier = "GoalCell"

    private lazy var ringView: RingView = {
        let ring = RingView()
        ring.translatesAutoresizingMaskIntoConstraints = false
        return ring
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .muted
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var radioView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.indicatorBorder.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 11, weight: .bold)
        imageView.image = UIImage(systemName: "checkmark", withConfiguration: config)
        imageView.tintColor = .white
        imageView.isHidden = true
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

    private func configureUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.line.cgColor
    }

    private func configureConstraints() {
        contentView.addSubview(ringView)
        contentView.addSubview(textStackView)
        contentView.addSubview(radioView)
        radioView.addSubview(checkImageView)

        NSLayoutConstraint.activate([
            ringView.widthAnchor.constraint(equalToConstant: 64),
            ringView.heightAnchor.constraint(equalToConstant: 64),
            ringView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ringView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            radioView.widthAnchor.constraint(equalToConstant: 24),
            radioView.heightAnchor.constraint(equalToConstant: 24),
            radioView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            radioView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            textStackView.leadingAnchor.constraint(equalTo: ringView.trailingAnchor, constant: 16),
            textStackView.trailingAnchor.constraint(equalTo: radioView.leadingAnchor, constant: -16),
            textStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            checkImageView.centerXAnchor.constraint(equalTo: radioView.centerXAnchor),
            checkImageView.centerYAnchor.constraint(equalTo: radioView.centerYAnchor)
        ])
    }

    func configure(data: GoalModel, isSelected: Bool) {
        ringView.configure(minutes: data.minutes, progress: data.progress)
        titleLabel.text = data.title
        detailLabel.text = data.detail

        if isSelected {
            contentView.layer.borderWidth = 1.5
            contentView.layer.borderColor = UIColor.green1.cgColor
            radioView.backgroundColor = .green1
            radioView.layer.borderColor = UIColor.green1.cgColor
            checkImageView.isHidden = false
        } else {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.line.cgColor
            radioView.backgroundColor = .clear
            radioView.layer.borderColor = UIColor.indicatorBorder.cgColor
            checkImageView.isHidden = true
        }
    }
}
