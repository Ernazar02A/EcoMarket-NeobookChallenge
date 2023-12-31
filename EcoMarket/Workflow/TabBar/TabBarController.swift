//
//  TabBarController.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    var presenter: TabBarPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        tabBar.tintColor = .mainGreen
        tabBar.unselectedItemTintColor = .gray1
        delegate = self
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
        let infoView = InfoViewController()
        let tabBarItem = UITabBarItem(title: "help", image: .init(named: "help"), selectedImage: .init(named: "help"))
        infoView.tabBarItem = tabBarItem
        let infoViewController = infoView

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

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            presenter.didSelectTab(at: index)
        }
    }
}
