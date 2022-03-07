//
//  WeatherModel.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: WeatherMain
    let name: String?
}

struct Weather: Decodable {
    let description: String?
    let icon: String?
}

struct WeatherMain: Decodable {
    let temp: Double?
    let temp_min: Double?
    let temp_max: Double?
}
