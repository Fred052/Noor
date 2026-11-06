//
//  GoalsController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//
import UIKit

class GoalsController: BaseController {

    private let viewModel = GoalsViewModel()

    private lazy var navBar: OnboardingNavBar = {
        let bar = OnboardingNavBar(step: 3, showSkip: true)
        bar.onBackTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        bar.onSkipTap = {
            self.navigationController?.pushViewController(PersonalizeController(), animated: true)
        }
        return bar
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 38
        paragraph.maximumLineHeight = 38
        label.attributedText = NSAttributedString(
            string: "Start with what feels right.",
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
        label.text = "A little time each day can make a meaningful difference."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .muted
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GoalCell.self, forCellWithReuseIdentifier: GoalCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .sage
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        imageView.image = UIImage(systemName: "seal", withConfiguration: config)
        imageView.tintColor = .green1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Miss a day? Nothing is lost. Pick up whenever you like, and change your goal anytime."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .ink
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

    private lazy var skipForNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip for now", for: .normal)
        button.setTitleColor(.green1, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(skipForNowTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func configureConstraints() {
        view.addSubview(navBar)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(collectionView)
        view.addSubview(infoContainerView)
        infoContainerView.addSubview(infoImageView)
        infoContainerView.addSubview(infoLabel)
        view.addSubview(continueButton)
        view.addSubview(skipForNowButton)

        let count = viewModel.numberOfGoals
        let collectionHeight = CGFloat(count) * 96 + CGFloat(count - 1) * 12

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

            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: collectionHeight),

            infoContainerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            infoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoContainerView.heightAnchor.constraint(equalToConstant: 83),

            infoImageView.widthAnchor.constraint(equalToConstant: 22),
            infoImageView.heightAnchor.constraint(equalToConstant: 22),
            infoImageView.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 14),
            infoImageView.centerYAnchor.constraint(equalTo: infoContainerView.centerYAnchor),

            infoLabel.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 12),
            infoLabel.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -12),
            infoLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: 12),
            infoLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -24),

            skipForNowButton.heightAnchor.constraint(equalToConstant: 54),
            skipForNowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipForNowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipForNowButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            continueButton.heightAnchor.constraint(equalToConstant: 54),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: skipForNowButton.topAnchor, constant: -8)
        ])
    }

    override func configureViewModel() {
        viewModel.onSelectionChanged = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    @objc private func continueTapped() {
        navigationController?.pushViewController(PersonalizeController(), animated: true)
    }

    @objc private func skipForNowTapped() {
    }
}

extension GoalsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfGoals
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalCell.identifier, for: indexPath) as! GoalCell
        cell.configure(data: viewModel.goal(at: indexPath.item),
                       isSelected: viewModel.isSelected(at: indexPath.item))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 96)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectGoal(at: indexPath.item)
    }
}
