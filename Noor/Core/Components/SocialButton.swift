//
//  SocialButton.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

class SocialButton: UIButton {

    init(title: String, icon: UIImage?) {
        super.init(frame: .zero)

        var config = UIButton.Configuration.plain()
        config.title = title
        config.image = icon
        config.imagePadding = 8
        config.baseForegroundColor = .green1
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 16, weight: .semibold)
            return outgoing
        }
        configuration = config

        backgroundColor = .white
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.line.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
