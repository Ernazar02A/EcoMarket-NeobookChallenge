//
//  NetworkManager.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import Foundation

struct NetworkManager {
    
    /// Синглтон-экземпляр `NetworkManager`.
    static let shared = NetworkManager()
    
    /// Перечисление для определения типов HTTP-запросов.
    ///
    /// Данные значения используются для указания метода HTTP-запроса при создании `URLRequest`
    enum TypeRequest: String {
        /// GET-запрос, используется для получения данных.
        case get = "GET"
        
        /// POST-запрос, часто используется для отправки данных на сервер.
        case post = "POST"
        
        /// PUT-запрос, обычно используется для обновления существующих данных на сервере.
        case put = "PUT"
        
        /// DELETE-запрос, используется для удаления данных на сервере.
        case delete = "DELETE"
        
        /// PATCH-запрос, применяется для частичного обновления данных на сервере.
        case patch = "PATCH"
    }
    
    /// Создает `URLRequest` с заданными параметрами.
    /// - Parameters:
    ///   - typeRequest: Тип HTTP-запроса.
    ///   - url: Строка URL для запроса.
    ///   - token: Токен авторизации (необязательный).
    ///   - parameters: Параметры запроса (необязательные).
    /// - Returns: Готовый объект `URLRequest` или `nil`, если произошла ошибка.
    func createRequest(typeRequest: TypeRequest, url: String, token: String?, parameters: [String: Any]?) -> URLRequest? {
        // Проверка валидности URL
        guard let url = URL(string: url) else {
            return nil
        }
        
        // Инициализация и настройка URLRequest.
        var request = URLRequest(url: url)
        
        // Добавление токена авторизации в заголовки запроса, если он предоставлен.
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Сериализация параметров в JSON и добавление в тело запроса.
        if let parameter = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: [])
            } catch {
                return nil
            }
        }
        
        // Установка типа HTTP-метода для запроса.
        request.httpMethod = typeRequest.rawValue
        
        // Установка заголовков запроса.
        request.allHTTPHeaderFields = [
            "Content-type" : "application/json; charset=UTF-8",
        ]
        return request
    }
}
