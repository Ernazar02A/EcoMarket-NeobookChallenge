//
//  ListProductPresenter.swift
//  EcoMarket
//
//  Created by Ernazar on 17/12/23.
//

import Foundation

protocol ListProductPresenterProtocol: AnyObject {
    init(view: ListProductViewProtocol, model: ListProductModelProtocol, category: ProductCategory)
    func setData(category: ProductCategory)
    func getProduct(_ indexPath: IndexPath) -> Product
    func getCategorys()
    var countProduct: Int { get }
    var countCategorys: Int { get }
    func getCategory(_ indexPath: IndexPath) -> ProductCategory
}

protocol ListProductViewProtocol: AnyObject {
    func reloadData()
}

class ListProductPresenter: ListProductPresenterProtocol {
    
    weak var view: ListProductViewProtocol?
    private var model: ListProductModelProtocol?
    
    private var products: [Product] = [] {
        didSet {
            view?.reloadData()
        }
    }
    
    private var categorys: [ProductCategory] = []
    
    var countProduct: Int {
        products.count
    }
    
    var countCategorys: Int {
        categorys.count
    }
    
    required init(view: ListProductViewProtocol, model: ListProductModelProtocol, category: ProductCategory) {
        self.view = view
        self.model = model
        setData(category: category)
    }
    
    func setData(category: ProductCategory) {
        chagenSelectedCategory(category: category)
        model?.fetchData(category: category.name, completion: { [weak self] result in
            switch result {
            case .success(let model):
                self?.products = model
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func updateData(index: IndexPath) {
        let model = categorys[index.row]
        setData(category: model)
        chagenSelectedCategory(category: model)
    }
    
    func chagenSelectedCategory(category: ProductCategory) {
        guard let index = categorys.firstIndex(where: {$0.name == category.name}) else { return }
        categorys[index].selected = true
    }
    
    
    func getProduct(_ indexPath: IndexPath) -> Product {
        products[indexPath.row]
    }
    
    func getCategorys() {
        
    }
    
    func getCategory(_ indexPath: IndexPath) -> ProductCategory {
        categorys[indexPath.row]
    }
}
