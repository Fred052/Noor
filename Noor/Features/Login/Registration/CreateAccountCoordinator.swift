//
//  CreateAccountCoordinator.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import UIKit

class CreateAccountCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CreateAccountViewModel(manager: AuthManager())
        let controller = CreateAccountController(viewModel: viewModel)
        navigationController.show(controller, sender: nil)
    }
}
