//
//  SignInController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

class SignInController: BaseController {

    private let viewModel: SignInViewModel

    private lazy var navBar: OnboardingNavBar = {
        let bar = OnboardingNavBar(step: 0)
        bar.onBackTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return bar
    }()

    private lazy var logoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green1
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nurMark")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 38
        paragraph.maximumLineHeight = 38
        label.attributedText = NSAttributedString(
            string: "Welcome back.",
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
        label.text = "Sign in to keep your bookmarks, notes and memorization in sync."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .muted
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var appleButton: SocialButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let icon = UIImage(systemName: "apple.logo", withConfiguration: config)
        let button = SocialButton(title: "Apple", icon: icon)
        button.addTarget(self, action: #selector(appleTapped), for: .touchUpInside)
        return button
    }()

    private lazy var googleButton: SocialButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let icon = UIImage(named: "googleIcon")
        let button = SocialButton(title: "Google", icon: icon)
        button.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
        return button
    }()

    private lazy var socialStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appleButton, googleButton])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .line
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "or with email"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var rightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .line
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var emailField: AuthTextField = {
        let field = AuthTextField(iconName: "envelope",
                                  placeholder: "name@example.com",
                                  keyboardType: .emailAddress)
        return field
    }()

    private lazy var passwordField: AuthTextField = {
        let field = AuthTextField(iconName: "lock",
                                  placeholder: "••••••••••",
                                  isSecure: true)
        return field
    }()

    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.green1, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .green1
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var newToNurLabel: UILabel = {
        let label = UILabel()
        label.text = "New to NUR?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .muted
        return label
    }()

    private lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create account", for: .normal)
        button.setTitleColor(.green1, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        return button
    }()

    private lazy var newToNurStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newToNurLabel, createAccountButton])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var continueWithoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue without an account", for: .normal)
        button.setTitleColor(.green1, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(continueWithoutTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.text = "The Quran stays free either way. Prototype: no real sign- in."
        label.font = .systemFont(ofSize: 13)
        label.textColor = .muted
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    override func configureConstraints() {
        view.addSubview(navBar)
        view.addSubview(logoContainerView)
        logoContainerView.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(socialStackView)
        view.addSubview(leftLineView)
        view.addSubview(orLabel)
        view.addSubview(rightLineView)
        view.addSubview(fieldsStackView)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(newToNurStackView)
        view.addSubview(continueWithoutButton)
        view.addSubview(captionLabel)

        NSLayoutConstraint.activate([

            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44),

            logoContainerView.widthAnchor.constraint(equalToConstant: 56),
            logoContainerView.heightAnchor.constraint(equalToConstant: 56),
            logoContainerView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
            logoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            logoImageView.widthAnchor.constraint(equalToConstant: 34),
            logoImageView.heightAnchor.constraint(equalToConstant: 34),
            logoImageView.centerXAnchor.constraint(equalTo: logoContainerView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: logoContainerView.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: logoContainerView.bottomAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            socialStackView.heightAnchor.constraint(equalToConstant: 54),
            socialStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 22),
            socialStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            socialStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            orLabel.topAnchor.constraint(equalTo: socialStackView.bottomAnchor, constant: 16),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            leftLineView.heightAnchor.constraint(equalToConstant: 1),
            leftLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leftLineView.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -12),
            leftLineView.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),

            rightLineView.heightAnchor.constraint(equalToConstant: 1),
            rightLineView.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 12),
            rightLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rightLineView.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),

            fieldsStackView.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 16),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            forgotPasswordButton.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            signInButton.heightAnchor.constraint(equalToConstant: 54),
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 18),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            newToNurStackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            newToNurStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            captionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            captionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            continueWithoutButton.heightAnchor.constraint(equalToConstant: 44),
            continueWithoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueWithoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueWithoutButton.bottomAnchor.constraint(equalTo: captionLabel.topAnchor, constant: -6)
        ])
    }

    override func configureViewModel() {
        emailField.onTextChanged = { [weak self] text in
            self?.viewModel.email = text
        }
        passwordField.onTextChanged = { [weak self] text in
            self?.viewModel.password = text
        }

        viewModel.success = {
            print("Signed in -> Home / Paywall (hələ yoxdur)")
        }
        viewModel.error = { [weak self] message in
            self?.showDefaultAlert(message: message)
        }
        viewModel.passwordResetSent = { [weak self] in
            self?.showDefaultAlert(title: "Check your email",
                                   message: "We sent you a link to reset your password.")
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func appleTapped() {
        viewModel.signInWithApple()
    }

    @objc private func googleTapped() {
        viewModel.signInWithGoogle(presenting: self)
    }

    @objc private func forgotPasswordTapped() {
        viewModel.resetPassword()
    }

    @objc private func signInTapped() {
        view.endEditing(true)
        viewModel.signIn()
    }

    @objc private func createAccountTapped() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = CreateAccountCoordinator(navigationController: navigationController)
        coordinator.start()
    }

    @objc private func continueWithoutTapped() {
        print("Continue without an account -> Paywall")
    }
}
