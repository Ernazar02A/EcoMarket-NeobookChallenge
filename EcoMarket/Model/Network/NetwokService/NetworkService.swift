//
//  NetworkService.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import Foundation

enum TypeRequestError: Error {
    case tokenNil
    case requestNil
    case responseNil
    case dataNil
    case selfNil
    case decodeError(Error)
    case encodeError(Error)
    case errorStatusCode(Int)
    case errorRequest(Error)
    case unKnown(Error)
}

class NetworkService {
    
    static let shared = NetworkService()
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let url = APIEndpoints.self
    let manager = NetworkManager.shared
    func fetchCategory(completion: @escaping (Result<[ProductCategory], TypeRequestError>) -> Void) {
        guard let request = NetworkManager.shared.createRequest(typeRequest: .get, url: url.getProductCategorysUrl, token: nil, parameters: nil) else {
            completion(.failure(.requestNil))
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.errorRequest(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseNil))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataNil))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let model = try self.decoder.decode([ProductCategory].self, from: data)
                    completion(.success(model))
                    return
                } catch {
                    completion(.failure(.decodeError(error)))
                    return
                }
            default :
                completion(.failure(.errorStatusCode(httpResponse.statusCode)))
                return
            }
        }.resume()
    }
}
