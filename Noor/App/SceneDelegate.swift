//
//  SceneDelegate.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 04.11.26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let splash = SplashController()
        let navigationController = UINavigationController(rootViewController: splash)
        navigationController.setNavigationBarHidden(true, animated: false)
        let window = UIWindow(windowScene: windowScene)
        
        splash.onFinish = { [weak navigationController] in
            navigationController?.setViewControllers([WelcomeController()], animated: false)
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

