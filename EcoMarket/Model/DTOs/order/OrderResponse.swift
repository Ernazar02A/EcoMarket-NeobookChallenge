//
//  OrderResponse.swift
//  EcoMarket
//
//  Created by Ernazar on 24/12/23.
//

import Foundation

struct OrderResponse: Decodable {
    var orderedProducts: [OrderItem]
    var phoneNumber: String
    var address: String
    var referencePoint: String
    var comments: String
    var totalAmount: String
    var createdAt: String
    var deliveryCost: Int
    
    
    enum CodingKeys: String, CodingKey {
        case orderedProducts = "ordered_products"
        case phoneNumber = "phone_number"
        case address
        case referencePoint = "reference_point"
        case comments
        case totalAmount = "total_amount"
        case createdAt = "created_at"
        case deliveryCost = "delivery_cost"
    }
}
