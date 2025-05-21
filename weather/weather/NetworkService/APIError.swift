//
//  APIError.swift
//  weather
//
//  Created by Денис Ефименков on 21.05.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidCoordinates
    case noData
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int)
    case sslError(description: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Неверный URL запроса"
        case .invalidCoordinates: return "Недопустимые координаты"
        case .noData: return "Сервер не вернул данные"
        case .invalidResponse: return "Неверный ответ сервера"
        case .decodingError(let error): return "Ошибка обработки данных: \(error.localizedDescription)"
        case .serverError(let code): return "Ошибка сервера (код \(code))"
        case .sslError(let desc): return "Проблема с безопасным соединением: \(desc)"
        }
    }
}
