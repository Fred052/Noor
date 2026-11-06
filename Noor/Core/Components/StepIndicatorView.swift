//
//  StepIndicatorView.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 04.11.26.
//

import UIKit

class StepIndicatorView: UIView {
    
    private let totalStep = 4
    private let currentStep: Int
    private var dots: [UIView] = []
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(currentStep: Int) {
        self.currentStep = currentStep
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureDots()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDots() {
        for step in 1...totalStep {
            let dot = UIView()
            dot.layer.cornerRadius = 2
            dot.backgroundColor = step <= currentStep ? .green1 : .dotInactive
            dot.translatesAutoresizingMaskIntoConstraints = false
            dots.append(dot)
            stackView.addArrangedSubview(dot)
        }
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        for(index,dot) in dots.enumerated() {
            let step = index + 1
            let width: CGFloat = (step == currentStep) ? 28 : 8
            
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: width),
                dot.heightAnchor.constraint(equalToConstant: 4)
            ])

        }
    }
}
