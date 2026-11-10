//
//  BaseController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 04.11.26.
//
import UIKit

class BaseController: UIViewController {
    
    let contentGuide = UILayoutGuide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ivory
        
        configureGuide()
        configureUI()
        configureConstraints()
        configureViewModel()
    }
    
    private func configureGuide() {
        view.addLayoutGuide(contentGuide)
        NSLayoutConstraint.activate([
            contentGuide.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentGuide.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 350 / 390)
        ])
    }
    
    func verticalGap(_ designValue: CGFloat) -> UILayoutGuide {
        let guide = UILayoutGuide()
        view.addLayoutGuide(guide)
        guide.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: designValue)
        return guide
    }

    
    func configureUI() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureViewModel() {
        
    }
}
