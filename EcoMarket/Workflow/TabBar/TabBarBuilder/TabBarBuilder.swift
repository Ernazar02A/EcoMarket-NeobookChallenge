//
//  TabBarBuilder.swift
//  EcoMarket
//
//  Created by Ernazar on 15/12/23.
//

import Foundation

class TabBarBuilder: TabBarBuilderProtocol {
    func buildTabBarController() -> TabBarController {
        let tabBarContoller = TabBarController()
        let tabBarPresenter = TabBarPresenter(view: tabBarContoller)
        let tabBarRouter = TabBarRouter(tabBarController: tabBarContoller)
        tabBarPresenter.router = tabBarRouter
        tabBarContoller.presenter = tabBarPresenter
        return tabBarContoller
    }
}
