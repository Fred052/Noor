//
//  QuranController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import UIKit

final class QuranController: BaseController {
    
    private let viewModel: QuranViewModel
    
    var onSurahSelected: ((Surah) -> Void)?
    var onFilterTap: (() -> Void)?
    
    init(viewModel: QuranViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var filterBarButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        let icon = UIImage(named: "iconFilter")?.resized(to: CGSize(width: 22, height: 22))
        button.setImage(icon, for: .normal)
        button.tintColor = .ink
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.line.cgColor
        button.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(QuranHeaderCell.self, forCellWithReuseIdentifier: QuranHeaderCell.identifier)
        collectionView.register(SurahCell.self, forCellWithReuseIdentifier: SurahCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func configureUI() {
        title = "Quran"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = filterBarButton
        
        configureNavigationBarApprearance()
        
        view.addSubview(collectionView)
    }
    
    private func configureNavigationBarApprearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ivory
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [
            .font: UIFont.serif(34),
            .foregroundColor: UIColor.green1
        ]
        appearance.titleTextAttributes = [
            .font: UIFont.serif(18),
            .foregroundColor: UIColor.green1
        ]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configureViewModel() {
        viewModel.success = { [weak self] in
            self?.reloadSurahs()
        }
        viewModel.error = { [weak self] message in
            self?.showDefaultAlert(message: message)
        }
        viewModel.getSurahList()
    }
    
    private func reloadSurahs() {
        UIView.performWithoutAnimation {
            collectionView.reloadSections(IndexSet(integer: 1))
        }
    }
    
    @objc private func filterTapped() {
        onFilterTap?()
    }
}

extension QuranController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : viewModel.surahs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuranHeaderCell.identifier, for: indexPath) as! QuranHeaderCell
            cell.configure(chipTitles: viewModel.chipTitles,
                           selectedChipIndex: viewModel.selectedSortIndex,
                           searchText: viewModel.currentSearchText)
            cell.onSearchChange = { [weak self] text in
                self?.viewModel.search(text)
            }
            cell.onChipSelect = { [weak self] index in
                self?.viewModel.selectSort(at: index)
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SurahCell.identifier, for: indexPath) as! SurahCell
        let isLast = indexPath.item == viewModel.surahs.count - 1
        cell.configure(surah: viewModel.surahs[indexPath.item], showSeperator: !isLast)
        return cell
    }
}

extension QuranController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        if indexPath.section == 0 {
            return CGSize(width: width, height: 168)
        }
        return CGSize(width: width - 40, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        }
        return UIEdgeInsets(top: 8, left: 20, bottom: 16, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1, viewModel.surahs.indices.contains(indexPath.item) else { return }
        onSurahSelected?(viewModel.surahs[indexPath.item])
    }
}
