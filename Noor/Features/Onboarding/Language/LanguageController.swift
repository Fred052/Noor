//
//  LanguageController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 05.11.26.
//

import UIKit

class LanguageController: BaseController {
    
    private let viewModel = LanguageViewModel()
    
    
    private lazy var navBar: OnboardingNavBar = {
        let bar = OnboardingNavBar(step: 2)
        bar.onBackTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return bar
    }()
    
    private lazy var globeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .sage
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var globeImageView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
        let image = UIImage(systemName: "globe", withConfiguration: config)
        imageView.image = image
        imageView.tintColor = .green1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 38
        paragraph.maximumLineHeight = 38
        label.attributedText = NSAttributedString(
            string: "Make Noor yours.",
            attributes: [
                .font: UIFont.newsReader(34),
                .foregroundColor: UIColor.green1,
                .kern: -0.34,
                .paragraphStyle: paragraph
            ])
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your preferred app language."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .muted
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LanguageCell.self, forCellWithReuseIdentifier: LanguageCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "info.circle")
        imageView.image = image
        imageView.tintColor = .muted
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 17.5
        paragraph.maximumLineHeight = 17.5
        label.attributedText = NSAttributedString(
            string: "This changes the app only. Your Quran translation language is a separate setting.",
            attributes: [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.muted,
                .paragraphStyle: paragraph
            ])
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .green1
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func configureConstraints() {
        view.addSubview(navBar)
        view.addSubview(globeContainerView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(collectionView)
        view.addSubview(infoImageView)
        view.addSubview(infoLabel)
        view.addSubview(continueButton)
        globeContainerView.addSubview(globeImageView)
        
        let count = viewModel.numberOfLanguage
        let collectionHeight = CGFloat(count) * 54 + CGFloat(count - 1) * 8
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44),
            
            globeContainerView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 12),
            globeContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            globeContainerView.widthAnchor.constraint(equalToConstant: 48),
            globeContainerView.heightAnchor.constraint(equalToConstant: 48),
            
            globeImageView.centerXAnchor.constraint(equalTo: globeContainerView.centerXAnchor),
            globeImageView.centerYAnchor.constraint(equalTo: globeContainerView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: globeContainerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: collectionHeight),
            
            infoImageView.topAnchor.constraint(equalTo: infoLabel.topAnchor, constant: 2),
            infoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoImageView.widthAnchor.constraint(equalToConstant: 18),
            infoImageView.heightAnchor.constraint(equalToConstant: 18),
            
            infoLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 14),
            infoLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: 8),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    override func configureViewModel() {
        viewModel.onSelectionChanged = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    @objc private func continueTapped() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = GoalsCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}

extension LanguageController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfLanguage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LanguageCell.identifier, for: indexPath) as! LanguageCell
        cell.configure(data: viewModel.language(at: indexPath.item), isSelected: viewModel.isSelected(at: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return  CGSize(width: view.frame.width - 40, height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectLanguage(at: indexPath.item)
    }
}
