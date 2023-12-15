//
//  TabBarPresenter.swift
//  EcoMarket
//
//  Created by Ernazar on 15/12/23.
//

import Foundation

class TabBarPresenter: TabBarPresenterProtocol {
    weak var view: TabBarController?
    var router: TabBarRouterProtocol!

    init(view: TabBarController) {
        self.view = view
    }

    func didSelectTab(at index: Int) {
        switch index {
        case 0:
            router.navigateToHome()
        case 1:
            router.navigateToBusket()
        case 2:
            router.navigateToHistory()
        case 3:
            router.navigateToInfo()
        default:
            break
        }
    }
}
