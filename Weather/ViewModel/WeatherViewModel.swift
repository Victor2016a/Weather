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
}
