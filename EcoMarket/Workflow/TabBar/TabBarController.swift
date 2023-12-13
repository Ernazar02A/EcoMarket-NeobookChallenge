//
//  TabBarController.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        tabBar.tintColor = .mainGreen
        tabBar.unselectedItemTintColor = .gray1
    }
    
    private func setupViewControllers() {
        let homeViewController = createViewController(
            viewController: HomeViewController(),
            image: .init(named: "home"),
            selectedImage: .init(named: "home"),
            title: "Главная"
        )
        let busketViewController = createViewController(
            viewController: BusketViewController(),
            image: .init(named: "busket"),
            selectedImage: .init(named: "busket"),
            title: "Карзина"
        )
        let historyViewController = createViewController(
            viewController: HistoryViewController(),
            image: .init(named: "clock"),
            selectedImage: .init(named: "clock"),
            title: "История"
        )
        let infoViewController = createViewController(
            viewController: InfoViewController(),
            image: .init(named: "help"),
            selectedImage: .init(named: "help"),
            title: "Инфо"
        )

        setViewControllers(
            [homeViewController,busketViewController,historyViewController, infoViewController],
            animated: true
        )
    }
    
    private func createViewController(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?, title: String) -> UINavigationController {
        let viewContoller = UINavigationController(rootViewController: viewController)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        viewContoller.tabBarItem = tabBarItem
        return viewContoller
    }
}
