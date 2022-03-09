//
//  ViewController.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    var baseView = WeatherListView()
    private var viewModel = WeatherViewModel()
    private var index = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadWeathersData()
    }
    
    override func loadView() {
        let barButtonTemp = UIBarButtonItem(title: "Fº", style: .plain, target: self, action: #selector(tapNavTemp))
        let batButtonMap = UIBarButtonItem(image: UIImage(named: "map"), style: .plain, target: self, action: #selector(tapNavMap))
        navigationItem.rightBarButtonItems = [batButtonMap, barButtonTemp]
        view = baseView
    }
    
    @objc func tapNavTemp() {
        if let cell = baseView.tableView.cellForRow(at: index) as? WeatherTableViewCell {
            let weathers = viewModel.cellForRow(at: index)
            
            if navigationItem.rightBarButtonItems?[1].title == "Fº" {
            guard let temp = weathers.main.temp else { return }
            cell.temperatureLabel.text = String(format: "%.f", convertTemperature(temp)) + "º"
            
            guard let tempMin = weathers.main.temp_min else { return }
            cell.temperatureMinLabel.text = "Min: " + String(format: "%.f", convertTemperature(tempMin)) + "º"
            
            guard let tempMax = weathers.main.temp_max else { return }
            cell.temperatureMaxLabel.text = "Max: " + String(format: "%.f", convertTemperature(tempMax)) + "º"
            navigationItem.rightBarButtonItems?[1].title = "Cº"
            } else {
            cell.temperatureLabel.text =  String(format: "%.f", weathers.main.temp ?? "") + "º"
            cell.temperatureMinLabel.text = "Min: " + String(format: "%.f", weathers.main.temp_min ?? "") + "º"
            cell.temperatureMaxLabel.text = "Max: " + String(format: "%.f", weathers.main.temp_max ?? "") + "º"
            navigationItem.rightBarButtonItems?[1].title = "Fº"
            }
        }
    }
    
    @objc func tapNavMap() {
        navigationController?.pushViewController(WeatherMapViewController(weathersList: viewModel.cellForRow(at: index)), animated: false)
    }
    
    private func loadWeathersData() {
        self.viewModel.fetchWeathersData { [weak self] in
            self?.baseView.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        baseView.tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        baseView.tableView.dataSource = self
    }
}

extension WeatherListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return .init() }
        
        let weathers = viewModel.cellForRow(at: indexPath)
        
        cell.cityLabel.text = weathers.name
        cell.descriptionLabel.text = weathers.weather[indexPath.row].description
        cell.temperatureLabel.text =  String(format: "%.f", weathers.main.temp ?? "") + "º"
        cell.temperatureMinLabel.text = "Min: " + String(format: "%.f", weathers.main.temp_min ?? "") + "º"
        cell.temperatureMaxLabel.text = "Max: " + String(format: "%.f", weathers.main.temp_max ?? "") + "º"
        
        guard let icon = weathers.weather[indexPath.row].icon else { return cell }
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else { return cell }

        URLSession.shared.dataTask(with: url) { (data, _ , error) in

        DispatchQueue.main.async {

            if let error = error {
                print("DataTask error: \(error.localizedDescription) ")
                return
            }

            guard let data = data else {
                print("Empty Data")
                return
            }

            if let image = UIImage(data: data){
                cell.iconWeatherImage.image = image
            }
        }

        }.resume()
        
        index = indexPath
        
        return cell
    }
}




