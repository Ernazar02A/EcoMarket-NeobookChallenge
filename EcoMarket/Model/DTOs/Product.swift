//
//  Product.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let image: String
    let quantity: Int
    let price: String
}
