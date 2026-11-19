//
//  FilterChipCell.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class FilterChipCell: UICollectionViewCell {
    
    static let identifier = "FilterChipCell"
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLeadingWithCheck = titleLabel.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: 6)
    private lazy var titleLeadingNoCheck = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, isSelected: Bool) {
        titleLabel.text = title
        titleLabel.textColor = isSelected ? .white : .ink
        contentView.backgroundColor = isSelected ? .green1 : .white
        contentView.layer.borderColor = (isSelected ? UIColor.green1 : UIColor.line).cgColor
        checkImageView.isHidden = !isSelected
        
        titleLeadingWithCheck.isActive = false
        titleLeadingNoCheck.isActive = false
        if isSelected {
            titleLeadingWithCheck.isActive = true
        } else {
            titleLeadingNoCheck.isActive = true
        }
    }
    
    private func configureUI() {
        contentView.addSubview(checkImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            checkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            checkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkImageView.widthAnchor.constraint(equalToConstant: 12),
            checkImageView.heightAnchor.constraint(equalToConstant: 12),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLeadingNoCheck
        ])
    }
}
