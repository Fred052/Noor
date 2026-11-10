//
//  PersonalizeCoordinator.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import UIKit

class PersonalizeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = PersonalizeController()
        navigationController.show(controller, sender: nil)
    }
}
