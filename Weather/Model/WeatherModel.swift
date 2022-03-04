//
//  WeatherModel.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import Foundation

struct WeatherData: Decodable {
    let weathers: [Weather]
    private enum CodingKeys: String, CodingKey {
        case weathers = "weather"
    }
}

struct Weather: Decodable {
    let descriptionTemp: String?
    private enum CodingKeys: String, CodingKey {
        case descriptionTemp = "description"
    }
}

struct WeatherMain: Decodable {
    let temperature: String?
    let temperature_min: String?
    let temperature_max: String?
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperature_min = "temp_min"
        case temperature_max = "temp_max"
    }
}
