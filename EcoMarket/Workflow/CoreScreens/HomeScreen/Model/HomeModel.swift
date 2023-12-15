//
//  HomeModel.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import Foundation

protocol HomeModelProtocol: AnyObject {
    func fetchData(completion: @escaping (Result<[ProductCategory], TypeRequestError>) -> Void)
}

class HomeModel: HomeModelProtocol {
    func fetchData(completion: @escaping (Result<[ProductCategory], TypeRequestError>) -> Void) {
        NetworkService.shared.fetchCategory(completion: completion)
    }
}
