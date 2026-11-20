//
//  SurahCell.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit

final class SurahCell: UICollectionViewCell {
    
    static let identifier = "SurahCell"
    
    private lazy var markerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "surahMarker"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .green1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .ink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arabicLabel: UILabel = {
        let label = UILabel()
        label.font = .arabic(24)
        label.textColor = .green1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chevronView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .muted
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .line
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var isHighlighted: Bool {
        didSet { contentView.alpha = isHighlighted ? 0.6 : 1 }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPlaying(_ isPlaying: Bool) {
        chevronView.image = UIImage(systemName: isPlaying ? "speaker.wave.2.fill" : "chevron.right")
        chevronView.tintColor = isPlaying ? .green1 : .muted
        titleLabel.textColor = isPlaying ? .green1 : .ink
    }
    
    
    func configure(surah: Surah, showSeperator: Bool, isPlaying: Bool) {
        numberLabel.text = "\(surah.number)"
        titleLabel.text = surah.englishName
        subtitleLabel.text = surah.subtitle
        arabicLabel.text = surah.arabicName
        seperator.isHidden = !showSeperator
        setPlaying(isPlaying)
    }
    
    private func configureUI() {
        contentView.addSubview(markerImageView)
        contentView.addSubview(numberLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(arabicLabel)
        contentView.addSubview(chevronView)
        contentView.addSubview(seperator)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            markerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            markerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            markerImageView.widthAnchor.constraint(equalToConstant: 40),
            markerImageView.heightAnchor.constraint(equalToConstant: 40),
            
            numberLabel.centerYAnchor.constraint(equalTo: markerImageView.centerYAnchor),
            numberLabel.centerXAnchor.constraint(equalTo: markerImageView.centerXAnchor),
            
            chevronView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chevronView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronView.widthAnchor.constraint(equalToConstant: 14),
            chevronView.heightAnchor.constraint(equalToConstant: 14),
            
            arabicLabel.trailingAnchor.constraint(equalTo: chevronView.leadingAnchor, constant: -12),
            arabicLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            titleLabel.leadingAnchor.constraint(equalTo: markerImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arabicLabel.leadingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arabicLabel.leadingAnchor, constant: -8),

            seperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            seperator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            seperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        arabicLabel.setContentHuggingPriority(.required, for: .horizontal)
        arabicLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
