//
//  WeatherViewModel.swift
//  weather
//
//  Created by Денис Ефименков on 21.05.2025.
//

import Foundation

class WeatherViewModel {
    private let session: URLSession
    private let apiKey = "fa8b3df74d4042b9aa7135114252304"
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.timeoutIntervalForResource = 20
        config.waitsForConnectivity = true
        
        self.session = URLSession(configuration: config)
    }
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<Forecast, Error>) -> Void) {
        guard (-90...90).contains(lat), (-180...180).contains(lon) else {
            DispatchQueue.main.async {
                completion(.failure(APIError.invalidCoordinates))
            }
            return
        }
        
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(lat),\(lon)&days=7"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(APIError.invalidURL))
            }
            return
        }
        
        print("Making request to:", url.absoluteString)

                
            
            

        }
}
