//
//  WelcomeContoller.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 04.11.26.
//
import UIKit

class WelcomeController: BaseController {
    
    private lazy var illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "welcomeIllustration")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var LogoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "nurlogo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stepIndicatorView: StepIndicatorView = {
        let indicator = StepIndicatorView(currentStep: 1)
        return indicator
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 38
        paragraph.maximumLineHeight = 38
        label.attributedText = NSAttributedString(
            string: "Bring the Quran closer to your everyday life.",
            attributes: [.paragraphStyle: paragraph,
                         .font: UIFont.newsReader(34),
                         .foregroundColor: UIColor.green1,
                         .kern: -0.34
                        ])
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Read, listen, reflect, and build a meaningful connection with the Holy Quran."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .muted
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .green1
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("I already have account", for: .normal)
        button.setTitleColor(.green1, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func configureConstraints() {
        view.addSubview(illustrationImageView)
        view.addSubview(LogoImageView)
        view.addSubview(stepIndicatorView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(getStartedButton)
        view.addSubview(loginButton)
        
        let image = illustrationImageView.image
        let imageRatio = (image?.size.height ?? 500) / (image?.size.width ?? 390)
        
        NSLayoutConstraint.activate([
            illustrationImageView.topAnchor.constraint(equalTo: view.topAnchor),
            illustrationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            illustrationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            illustrationImageView.heightAnchor.constraint(equalTo: illustrationImageView.widthAnchor, multiplier: imageRatio),
            
            LogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            LogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            LogoImageView.widthAnchor.constraint(equalToConstant: 34),
            LogoImageView.heightAnchor.constraint(equalToConstant: 34),
            
            stepIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stepIndicatorView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -14),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            subtitleLabel.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -32),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 54),
            
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            getStartedButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -8),
            getStartedButton.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
    
    @objc private func getStartedButtonTapped() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = LanguageCoordinator(navigationController: navigationController)
        coordinator.start()
    }
    
    @objc private func LoginButtonTapped() {
        guard let navigationController = self.navigationController else { return }
        let coordinator = SignInCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
