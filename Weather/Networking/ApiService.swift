//
//  ApiService.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getWeatherListData(complention: @escaping (Result<WeatherData, Error>) -> Void){
        
        LocationManager.shared.getUserLocation { [weak self] location in
            
            let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric&appid=b8d3341bed3153c9bdbaa47fe12ccf12&lang=pt"
            guard let url = URL(string: weatherUrl) else { return }
            
            self?.dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        complention(.failure(error))
                        print("DataTask: \(error.localizedDescription)")
                        return
                    }
                    guard let response = response as? HTTPURLResponse else {
                        print("Empty Response")
                        return
                    }
                    print("Response Status Code: \(response.statusCode)")
                    
                    guard let data = data else {
                        print("Empty Data")
                        return
                    }
                    do {
                        let jsonData = try JSONDecoder().decode(WeatherData.self, from: data)
                        complention(.success(jsonData))
                    }
                    catch let error {
                        complention(.failure(error))
                    }
                }
            }
            self?.dataTask?.resume()
        }
    }
}
