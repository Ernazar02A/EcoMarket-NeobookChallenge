//
//  Order.swift
//  EcoMarket
//
//  Created by Ernazar on 24/12/23.
//

import Foundation

struct Order: Codable {
    var products: [OrderItem]
    var phoneNumber: String
    var address: String
    var referencePoint: String
    var comments: String
    
    
    enum CodingKeys: String, CodingKey {
        case products
        case phoneNumber = "phone_number"
        case address
        case referencePoint = "reference_point"
        case comments
    }
}


