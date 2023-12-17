//
//  HomePresenter.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func reloadData()
}

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol, model: HomeModelProtocol)
    func getCategorys()
    func getNameCategory(_ indexPath: IndexPath) -> String
    func getCategory(_ indexPath: IndexPath) -> ProductCategory
    var countCategorys: Int { get }
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var model: HomeModelProtocol!
    
    var countCategorys: Int {
        productsCategorys.count
    }

    private var productsCategorys: [ProductCategory] = []
    
    required init(view: HomeViewProtocol, model: HomeModelProtocol) {
        self.view = view
        self.model = model
        getCategorys()
    }
    
    
    func getCategorys() {
        model.fetchData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.handleFetchResult(result: result)
            }
        }
    }
    
    private func handleFetchResult(result: Result<[ProductCategory], TypeRequestError>) {
        switch result {
        case .success(let data):
            productsCategorys = data
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    func getNameCategory(_ indexPath: IndexPath) -> String {
        productsCategorys[indexPath.row].name
    }
    
    func getCategory(_ indexPath: IndexPath) -> ProductCategory {
        productsCategorys[indexPath.row]
    }
}

