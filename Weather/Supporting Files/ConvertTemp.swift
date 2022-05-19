//
//  ConvertTemp.swift
//  Weather
//
//  Created by Victor Vieira on 08/03/22.
//

import Foundation

func convertToFahrenheit(_ tempCelsius: Double) -> Double {
  tempCelsius * 1.8 + 32
}

func convertToCelsius(_ tempFahrenheit: Double) -> Double {
  (tempFahrenheit - 32)/1.8
}
