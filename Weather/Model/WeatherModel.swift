//
//  WeatherModel.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import Foundation

struct WeatherList: Decodable {
    var list: [WeatherData]
}

struct WeatherData: Decodable {
    let weather: [Weather]
    var main: WeatherMain
    var name: String?
    let coord: WeatherCoordinate
}

struct WeatherCoordinate: Decodable {
    let lat: Double?
    let lon: Double?
}

struct Weather: Decodable {
    let description: String?
    let icon: String?
}

struct WeatherMain: Decodable {
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
}
