//
//  ProfileCoordinator.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 17.11.26.
//

import UIKit
import FirebaseAuth

final class ProfileCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let fullName = Auth.auth().currentUser?.displayName ?? ""
        let firstName = fullName.split(separator: " ").first.map(String.init) ?? "Guest"

        let viewModel = ProfileViewModel(userName: firstName)
        let controller = ProfileController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: false)
    }
}
