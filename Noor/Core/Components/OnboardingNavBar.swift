//
//  OnboardingNavBar.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 05.11.26.
//

import UIKit

class OnboardingNavBar: UIView {
    
    private let step: Int
    private let showSkip: Bool
    
    var onBackTap: (() -> Void)?
    var onSkipTap: (() -> Void)?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .ink
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.green1, for: .normal)
        button.isHidden = !showSkip
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stepIndicatorView: StepIndicatorView = {
        let indicator = StepIndicatorView(currentStep: step)
        indicator.isHidden = (step == 0)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(step: Int, showSkip: Bool = false) {
        self.step = step
        self.showSkip = showSkip
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        addSubview(stepIndicatorView)
        addSubview(backButton)
        addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            stepIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stepIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            skipButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            skipButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func backTapped() {
        onBackTap?()
        
    }
    
    @objc private func skipTapped() {
        onSkipTap?()
    }
}
