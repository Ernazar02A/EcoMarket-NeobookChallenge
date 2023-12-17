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
        baseUrl + "product-list/?category_name=" + $0
    }
}
