//
//  NetworkManager.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    enum TypeRequest: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    func createRequest(typeRequest: TypeRequest, url: String, token: String?, parameters: [String: Any]?, body: Data?) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        var request = URLRequest(url: url)

        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let parameter = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: [])
            } catch {
                return nil
            }
        }
        
        if let body = body {
            request.httpBody = body
        }

        request.httpMethod = typeRequest.rawValue
        
        request.allHTTPHeaderFields = [
            "Content-type" : "application/json; charset=UTF-8",
        ]
        return request
    }
}
