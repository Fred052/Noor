//
//  HomeCoordinator.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit
import FirebaseAuth

final class HomeCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let fullName = Auth.auth().currentUser?.displayName ?? ""
        let firstName = fullName.split(separator: " ").first.map(String.init) ?? "Friend"

        let viewModel = HomeViewModel(userName: firstName)
        let controller = HomeController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: false)
    }
}
