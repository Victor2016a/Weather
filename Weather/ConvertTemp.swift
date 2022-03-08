//
//  ConvertTemp.swift
//  Weather
//
//  Created by Victor Vieira on 08/03/22.
//

import Foundation

func convertTemperature(_ temp: Double) -> Double {
    var newTemp: Double
    newTemp = temp * 1.8 + 32
    return newTemp
}
