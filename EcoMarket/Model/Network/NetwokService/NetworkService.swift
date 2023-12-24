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
        guard let request = NetworkManager.shared.createRequest(typeRequest: .get, url: url.getProductCategorysUrl, token: nil, parameters: nil, body: nil) else {
            completion(.failure(.requestNil))
            return
        }
        
        self.request(request: request, decodeType: [ProductCategory].self, completion: completion)
    }
    
    func fetchProducts(with category: String, completion: @escaping (Result<[Product], TypeRequestError>) -> Void) {
        guard let request = NetworkManager.shared.createRequest(typeRequest: .get, url: url.getProductsUrl(category), token: nil, parameters: nil, body: nil) else {
            completion(.failure(.requestNil))
            return
        }
        
        self.request(request: request, decodeType: [Product].self, completion: completion)
    }
    
    func createOrder(with order: Order, completion: @escaping (Result<OrderResponse, TypeRequestError>) -> Void) {
        let o = Order(products: [.init(product: 1, quantity: 12)], phoneNumber: "123456", address: "Bishkek", referencePoint: "12345", comments: "text")
        var body: Data? = nil
        do {
            body = try encoder.encode(o)
        } catch {
            completion(.failure(.encodeError(error)))
        }
        guard let request = NetworkManager.shared.createRequest(typeRequest: .post, url: url.createOrder, token: nil, parameters: nil, body: body) else {
            completion(.failure(.requestNil))
            return
        }
        
        self.request(request: request, decodeType: OrderResponse.self, completion: completion)
    }
    
    private func request<T: Decodable>(request: URLRequest, decodeType: T.Type, completion: @escaping (Result<T, TypeRequestError>) -> Void) {
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
            self.handleStatusCode(data: data, statusCode: httpResponse.statusCode, decodeType: decodeType, completion: completion)
        }.resume()
    }
    
    private func handleStatusCode<T: Decodable>(data: Data, statusCode: Int, decodeType: T.Type, completion: @escaping (Result<T, TypeRequestError>) -> Void) {
        switch statusCode{
        case let successStatus where successStatus == 200 || successStatus == 201:
            handleSuccesStatus(data: data, decodeType: decodeType, completion: completion)
        default :
            completion(.failure(.errorStatusCode(statusCode)))
            return
        }
    }
    
    private func handleSuccesStatus<T: Decodable>(data: Data, decodeType: T.Type, completion: @escaping (Result<T, TypeRequestError>) -> Void) {
        do {
            let model = try decoder.decode(decodeType.self, from: data)
            completion(.success(model))
            return
        } catch {
            completion(.failure(.decodeError(error)))
            return
        }
    }
}
