//
//  QuranCoordinator.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import UIKit

final class QuranCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        
        let viewModel = QuranViewModel(manager: SurahManager())
        let controller = QuranController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: false)
    }
}
