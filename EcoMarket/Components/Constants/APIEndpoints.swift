//
//  APIEndpoints.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import Foundation

struct APIEndpoints {
    static let baseUrl = "https://neobook.online/ecobak/"
    static let getProductCategorysUrl = baseUrl + "product-category-list/"
    static var getProductsUrl: (String) -> String = {
        guard let encodedCategory = $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return  baseUrl + "product-list/"
        }
        if $0 == "Все" {
            return baseUrl + "product-list/"
        }
        return baseUrl + "product-list/?category_name=" + encodedCategory
    }
    
    static let createOrder = baseUrl + "order-create/"
}
