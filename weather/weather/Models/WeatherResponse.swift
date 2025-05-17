//
//  WeatherResponse.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: ForecastResponse?
}

struct Location: Codable {
    let name: String
    let lat: Double
    let lon: Double
}

struct CurrentWeather: Codable {
    let tempC: Double
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}
