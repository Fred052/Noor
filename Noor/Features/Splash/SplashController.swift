//
//  SplashController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 09.11.26.
//
import UIKit

class SplashController: BaseController {
    
    var onFinish: (() -> Void)?
    
    private lazy var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func configureConstraints() {
        view.addSubview(splashImageView)
        
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: view.topAnchor),
            splashImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splashImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splashImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.onFinish?()
        }
    }
}
