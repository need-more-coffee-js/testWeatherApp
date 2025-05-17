//
//  ForecastResponse.swift
//  weather
//
//  Created by Денис Ефименков on 17.05.2025.
//

import Foundation

struct ForecastResponse: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
}

struct Day: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

struct Hour: Codable {
    let time: String
    let tempC: Double
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}
