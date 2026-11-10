//
//  PersonalizeController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

class PersonalizeController: BaseController {

    private let viewModel = PersonalizeViewModel()

    private lazy var navBar: OnboardingNavBar = {
        let bar = OnboardingNavBar(step: 4)
        bar.onBackTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return bar
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 38
        paragraph.maximumLineHeight = 38
        label.attributedText = NSAttributedString(
            string: "How would you like to connect?",
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
        label.text = "Choose as many as you like."
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
        collectionView.register(InterestCell.self, forCellWithReuseIdentifier: InterestCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
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
            string: "No account needed. You can read the Quran right away and create one later if you wish.",
            attributes: [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.muted,
                .paragraphStyle: paragraph
            ])
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create My Experience", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .green1
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func configureConstraints() {
        view.addSubview(navBar)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(collectionView)
        view.addSubview(infoImageView)
        view.addSubview(infoLabel)
        view.addSubview(createButton)

        let count = viewModel.numberOfInterests
        let collectionHeight = CGFloat(count) * 68 + CGFloat(count - 1) * 8

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: collectionHeight),

            infoImageView.widthAnchor.constraint(equalToConstant: 18),
            infoImageView.heightAnchor.constraint(equalToConstant: 18),
            infoImageView.topAnchor.constraint(equalTo: infoLabel.topAnchor, constant: 2),
            infoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            infoLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: 8),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            createButton.heightAnchor.constraint(equalToConstant: 54),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButton.bottomAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 78)
        ])
    }

    override func configureViewModel() {
        viewModel.onSelectionChanged = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    @objc private func createTapped() {
        let titles = viewModel.selectedInterests.map { $0.title }
        
    }
}

extension PersonalizeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfInterests
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCell.identifier, for: indexPath) as! InterestCell
        cell.configure(data: viewModel.interest(at: indexPath.item),
                       isSelected: viewModel.isSelected(at: indexPath.item))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 68)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.toggleInterest(at: indexPath.item)
    }
}
