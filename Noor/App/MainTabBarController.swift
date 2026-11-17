//
//  MainTabBarController.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import UIKit

final class MainTabBarController: UITabBarController {

    private var homeCoordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureTabs()
    }

    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tabBarBg
        appearance.shadowColor = .line
        appearance.selectionIndicatorImage = makePillImage()

        let normal = appearance.stackedLayoutAppearance.normal
        normal.iconColor = .muted
        normal.titleTextAttributes = [
            .foregroundColor: UIColor.muted,
            .font: UIFont.systemFont(ofSize: 11, weight: .medium)
        ]

        let selected = appearance.stackedLayoutAppearance.selected
        selected.iconColor = .green1
        selected.titleTextAttributes = [
            .foregroundColor: UIColor.green1,
            .font: UIFont.systemFont(ofSize: 11, weight: .semibold)
        ]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

    private func makePillImage() -> UIImage {
        let size = CGSize(width: view.bounds.width / 5, height: 49)
        return UIGraphicsImageRenderer(size: size).image { _ in
            UIColor.sage.setFill()
            let rect = CGRect(x: (size.width - 58) / 2, y: 4, width: 58, height: 30)
            UIBezierPath(roundedRect: rect, cornerRadius: 15).fill()
        }
    }

    private func resizeIcon(named name: String) -> UIImage? {
        guard let image = UIImage(named: name) else {
            return nil
        }

        let size = CGSize(width: 24, height: 24)
        let renderer = UIGraphicsImageRenderer(size: size)

        let resizedImage = renderer.image { _ in
            let scale = min(size.width / image.size.width,
                            size.height / image.size.height)

            let width = image.size.width * scale
            let height = image.size.height * scale

            let rect = CGRect(x: (size.width - width) / 2,
                              y: (size.height - height) / 2,
                              width: width,
                              height: height)

            image.draw(in: rect)
        }

        return resizedImage.withRenderingMode(.alwaysTemplate)
    }

    private func configureTabs() {
        let homeNavigation = makeNavigationController(title: "Home", icon: "tabHome")
        let coordinator = HomeCoordinator(navigationController: homeNavigation)
        coordinator.start()
        homeCoordinator = coordinator

        viewControllers = [
            homeNavigation,
            makePlaceholderTab(title: "Quran", icon: "tabQuran"),
            makePlaceholderTab(title: "Hifz", icon: "tabHifz"),
            makePlaceholderTab(title: "Library", icon: "tabLibrary"),
            makePlaceholderTab(title: "Profile", icon: "tabProfile")
        ]
    }

    private func makeNavigationController(title: String, icon: String) -> UINavigationController {
        let navigation = UINavigationController()
        navigation.setNavigationBarHidden(true, animated: false)
        navigation.tabBarItem = UITabBarItem(
            title: title,
            image: resizeIcon(named: icon),
            selectedImage: nil
        )
        return navigation
    }

    private func makePlaceholderTab(title: String, icon: String) -> UINavigationController {
        let navigation = makeNavigationController(title: title, icon: icon)
        navigation.setViewControllers([PlaceholderController(title: title)], animated: false)
        return navigation
    }
}
