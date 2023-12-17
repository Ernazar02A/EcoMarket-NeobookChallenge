//
//  ListProductModel.swift
//  EcoMarket
//
//  Created by Ernazar on 17/12/23.
//

import Foundation

protocol ListProductModelProtocol: AnyObject {
    func fetchData(category: String, completion: @escaping (Result<[Product], TypeRequestError>) -> Void)
}

class ListProductModel: ListProductModelProtocol {
    func fetchData(category: String, completion: @escaping (Result<[Product], TypeRequestError>) -> Void) {
        NetworkService.shared.fetchProducts(with: category, completion: completion)
    }
}
