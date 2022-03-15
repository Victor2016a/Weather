//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import Foundation

class WeatherViewModel {
    
    private var apiService = ApiService()
    var weathers = [WeatherData]()
    
    func fetchWeathersData(completion: @escaping() -> Void) {
        apiService.getWeatherListData { [weak self] (result) in
            switch result {
            case .success(let lisOf):
                self?.weathers = lisOf.list
                completion()
            case .failure(let error):
                print("Error Processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        weathers.count
    }
    
    func cellForRow(at: IndexPath) -> WeatherData {
        weathers[at.row]
    }
    
    func convertAllTempToCelsius() {
        for i in 0 ..< weathers.count {
            weathers[i].main.temp = convertToCelsius(weathers[i].main.temp ?? 0)
            weathers[i].main.temp_min = convertToCelsius(weathers[i].main.temp_min ?? 0)
            weathers[i].main.temp_max = convertToCelsius(weathers[i].main.temp_max ?? 0)
        }
    }
    
    func convertAllTempToFahrenheit() {
        for i in 0 ..< weathers.count {
            weathers[i].main.temp = convertToFahrenheit(weathers[i].main.temp ?? 0)
            weathers[i].main.temp_min = convertToFahrenheit(weathers[i].main.temp_min ?? 0)
            weathers[i].main.temp_max = convertToFahrenheit(weathers[i].main.temp_max ?? 0)
        }
    }
}
