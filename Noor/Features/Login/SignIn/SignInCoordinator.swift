//
//  SignInCoordinator.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import UIKit

class SignInCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SignInViewModel(manager: AuthManager())
        let controller = SignInController(viewModel: viewModel)
        navigationController.show(controller, sender: nil)
    }
}
