//
//  TabBarRouter.swift
//  EcoMarket
//
//  Created by Ernazar on 15/12/23.
//

import UIKit

class TabBarRouter: TabBarRouterProtocol {
    weak var tabBarController: UITabBarController?

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func navigateToHome() {
        tabBarController?.selectedIndex = 0
    }

    func navigateToBusket() {
        tabBarController?.selectedIndex = 1
    }

    func navigateToHistory() {
        tabBarController?.selectedIndex = 2
    }

    func navigateToInfo() {
        tabBarController?.selectedIndex = 3
    }
}
