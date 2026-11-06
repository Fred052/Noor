//
//  AuthTextField.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

class AuthTextField: UIView {

    var onTextChanged: ((String) -> Void)?

    private let iconName: String
    private let placeholder: String
    private let isSecure: Bool
    private let keyboardType: UIKeyboardType

    var text: String {
        return textField.text ?? ""
    }

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = symbol(iconName)
        imageView.tintColor = .muted
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.muted])
        field.font = .systemFont(ofSize: 16)
        field.textColor = .ink
        field.keyboardType = keyboardType
        field.isSecureTextEntry = isSecure
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        field.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
        field.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(symbol("eye.slash"), for: .normal)
        button.tintColor = .muted
        button.isHidden = !isSecure
        button.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(iconName: String, placeholder: String, isSecure: Bool = false, keyboardType: UIKeyboardType = .default) {
        self.iconName = iconName
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        super.init(frame: .zero)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func symbol(_ name: String) -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .light)
        return UIImage(systemName: name, withConfiguration: config)
    }

    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 14
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.line.cgColor
        
        layer.shadowColor = UIColor.gold.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.shadowOpacity = 0
        
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureConstraints() {
        addSubview(iconImageView)
        addSubview(textField)
        addSubview(eyeButton)

        let textFieldTrailing = isSecure
            ? textField.trailingAnchor.constraint(equalTo: eyeButton.leadingAnchor, constant: -4)
            : textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),

            iconImageView.widthAnchor.constraint(equalToConstant: 22),
            iconImageView.heightAnchor.constraint(equalToConstant: 22),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textFieldTrailing,

            eyeButton.widthAnchor.constraint(equalToConstant: 32),
            eyeButton.heightAnchor.constraint(equalToConstant: 32),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            eyeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc private func didBeginEditing() {
        layer.borderColor = UIColor.green1.cgColor
        layer.shadowOpacity = 0.35
    }

    @objc private func didEndEditing() {
        layer.borderColor = UIColor.line.cgColor
        layer.shadowOpacity = 0
    }

    @objc private func textChanged() {
        onTextChanged?(text)
    }

    @objc private func eyeTapped() {
        textField.isSecureTextEntry.toggle()
        let name = textField.isSecureTextEntry ? "eye.slash" : "eye"
        eyeButton.setImage(symbol(name), for: .normal)
    }
}
