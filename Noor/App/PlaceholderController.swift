//
//  PlaceholderController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import UIKit

final class PlaceholderController: BaseController {

    private let titleText: String

    init(title: String) {
        self.titleText = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleText
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .green1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func configureUI() {
        view.addSubview(titleLabel)
    }

    override func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
