//
//  InterestCell.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

class InterestCell: UICollectionViewCell {

    static let identifier = "InterestCell"

    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .sage
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .green1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var checkboxView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
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
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.line.cgColor
    }

    private func configureConstraints() {
        contentView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkboxView)
        checkboxView.addSubview(checkImageView)

        NSLayoutConstraint.activate([
            iconContainerView.widthAnchor.constraint(equalToConstant: 44),
            iconContainerView.heightAnchor.constraint(equalToConstant: 44),
            iconContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),

            checkboxView.widthAnchor.constraint(equalToConstant: 24),
            checkboxView.heightAnchor.constraint(equalToConstant: 24),
            checkboxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkboxView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: checkboxView.leadingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            checkImageView.centerXAnchor.constraint(equalTo: checkboxView.centerXAnchor),
            checkImageView.centerYAnchor.constraint(equalTo: checkboxView.centerYAnchor)
        ])
    }

    func configure(data: InterestModel, isSelected: Bool) {
        titleLabel.text = data.title

        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        iconImageView.image = UIImage(systemName: data.iconName, withConfiguration: config)

        if isSelected {
            contentView.layer.borderWidth = 1.5
            contentView.layer.borderColor = UIColor.green1.cgColor
            checkboxView.backgroundColor = .green1
            checkboxView.layer.borderColor = UIColor.green1.cgColor
            checkImageView.isHidden = false
        } else {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.line.cgColor
            checkboxView.backgroundColor = .clear
            checkboxView.layer.borderColor = UIColor.indicatorBorder.cgColor
            checkImageView.isHidden = true
        }
    }
}
