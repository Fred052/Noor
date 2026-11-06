//
//  LanguageCell.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 05.11.26.
//

import UIKit

class LanguageCell: UICollectionViewCell {
    
    static let identifier = "LanguageCell"
    
    private lazy var nativeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var englishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.line.cgColor
    }
    
    private func configureConstraints() {
        contentView.addSubview(nativeNameLabel)
        contentView.addSubview(englishNameLabel)
        contentView.addSubview(radioView)
        radioView.addSubview(checkImageView)
        
        NSLayoutConstraint.activate([
            nativeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nativeNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            englishNameLabel.leadingAnchor.constraint(equalTo: nativeNameLabel.trailingAnchor, constant: 12),
            englishNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            radioView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            radioView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioView.widthAnchor.constraint(equalToConstant: 24),
            radioView.heightAnchor.constraint(equalToConstant: 24),
            
            checkImageView.centerXAnchor.constraint(equalTo: radioView.centerXAnchor),
            checkImageView.centerYAnchor.constraint(equalTo: radioView.centerYAnchor)
        ])
    }
    
    func configure(data: LanguageModel, isSelected: Bool) {
        nativeNameLabel.text = data.nativeName
        englishNameLabel.text = data.englishName
        
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
