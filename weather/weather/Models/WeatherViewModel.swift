//
//  WeatherViewModel.swift
//  weather
//
//  Created by Денис Ефименков on 21.05.2025.
//

import Foundation

class WeatherViewModel {
    private let apiKey = "fa8b3df74d4042b9aa7135114252304"
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<Forecast, Error>) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(lat),\(lon)&days=7"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        print("Sending request to:", urlString)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            // Вывод сырого ответа для отладки
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw API response:", jsonString)
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Forecast.self, from: data)
                completion(.success(response))
            } catch let decodingError {
                print("Full decoding error:", decodingError)
                completion(.failure(APIError.decodingError(decodingError)))
            }
        }.resume()
    }
}
