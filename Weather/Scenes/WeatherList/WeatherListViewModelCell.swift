//
//  WeatherListViewModelCell.swift
//  Weather
//
//  Created by Victor Vieira on 04/04/22.
//

import Foundation

class WeatherListViewModelCell {
  var cityName: String
  var description: String
  var icon: String
  var temperature: String
  var temperatureMin: String
  var temperatureMax: String
  
  init(cityName: String,
       description: String,
       icon: String,
       temperature: Double,
       temperatureMin: Double,
       temperatureMax: Double) {
    
    self.cityName = cityName
    self.description = description
    self.icon = icon
    self.temperature = String(format: "%.f", temperature) + "º"
    self.temperatureMin = "Min: " + String(format: "%.f", temperatureMin) + "º"
    self.temperatureMax = "Max: " + String(format: "%.f", temperatureMax) + "º"
  }
}
