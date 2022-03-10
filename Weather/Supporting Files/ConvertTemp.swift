//
//  ConvertTemp.swift
//  Weather
//
//  Created by Victor Vieira on 08/03/22.
//

import Foundation

func convertTemperature(_ tempCelsius: Double) -> Double {
    var tempFahrenheit: Double
    tempFahrenheit = tempCelsius * 1.8 + 32
    return tempFahrenheit
}
