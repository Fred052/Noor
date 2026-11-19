//
//  QuranHeaderCell.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import UIKit

class QuranHeaderCell: UICollectionViewCell {
    
    static let identifier = "QuranHeaderCell"
    
    var onSearchChange: ((String) -> Void)?
    var onChipSelect: ((Int) -> Void)?
    
    private var chipTitles: [String] = []
    private var selectedChipIndex = 0
    
    private lazy var searchContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.line.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .muted
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var searchTextField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Search surahs or verses",
            attributes: [.foregroundColor: UIColor.muted]
        )
        field.font = .systemFont(ofSize: 16)
        field.textColor = .ink
        field.returnKeyType = .search
        field.clearButtonMode = .whileEditing
        field.autocorrectionType = .no
        field.delegate = self
        field.addTarget(self, action: #selector(searchChanged), for: .editingChanged)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control =  UISegmentedControl(items: ["Surahs", "Juz", "Bookmarks"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = .white
        control.backgroundColor = UIColor.green1.withAlphaComponent(0.07)
        control.setTitleTextAttributes([.foregroundColor: UIColor.muted,
                                        .font: UIFont.systemFont(ofSize: 14, weight: .medium)],
                                       for:  .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.green1,
                                        .font: UIFont.systemFont(ofSize: 14, weight: .semibold)],
                                       for: .selected)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var chipsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilterChipCell.self, forCellWithReuseIdentifier: FilterChipCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(chipTitles: [String], selectedChipIndex: Int, searchText: String) {
        self.chipTitles = chipTitles
        self.selectedChipIndex = selectedChipIndex
        if searchTextField.text != searchText {
            searchTextField.text = searchText
        }
        chipsCollectionView.reloadData()
    }
    
    private func configureUI() {
        contentView.addSubview(searchContainer)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(chipsCollectionView)
        
        searchContainer.addSubview(searchIcon)
        searchContainer.addSubview(searchTextField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            searchContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            searchContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            searchContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            searchContainer.heightAnchor.constraint(equalToConstant: 48),

            searchIcon.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 14),
            searchIcon.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 20),
            searchIcon.heightAnchor.constraint(equalToConstant: 20),

            searchTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -14),
            searchTextField.topAnchor.constraint(equalTo: searchContainer.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor),

            segmentedControl.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 12),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),

            chipsCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 12),
            chipsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chipsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chipsCollectionView.heightAnchor.constraint(equalToConstant: 36),
            chipsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func searchChanged() {
        onSearchChange?(searchTextField.text ?? "")
    }
}

extension QuranHeaderCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension QuranHeaderCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        chipTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterChipCell.identifier, for: indexPath) as! FilterChipCell
        cell.configure(title: chipTitles[indexPath.item], isSelected: indexPath.item ==  selectedChipIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = chipTitles[indexPath.item]
        let textWidth = (title as NSString).size(withAttributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]).width
        let isSelected = indexPath.item == selectedChipIndex
        let width = ceil(textWidth) + (isSelected ? 46 : 28)
        return CGSize(width: width, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedChipIndex = indexPath.item
        collectionView.reloadData()
        onChipSelect?(indexPath.item)
    }
}
