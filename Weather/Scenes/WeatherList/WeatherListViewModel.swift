//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import Foundation

class WeatherListViewModel {
    
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
    
    func cellForRow(at indexPath: IndexPath) -> WeatherListViewModelCell {
      let weather = weathers[indexPath.row]
      return .init(
        cityName: weather.name ?? "",
        description: weather.weather.first?.description ?? "",
        icon: weather.weather.first?.icon ?? "",
        temperature: weather.main.temp ?? 0.0,
        temperatureMin: weather.main.temp_min ?? 0.0,
        temperatureMax: weather.main.temp_max ?? 0.0
      )
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
