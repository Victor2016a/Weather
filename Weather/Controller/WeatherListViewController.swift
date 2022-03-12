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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeathersData()
        configureTableView()
    }
    
    override func loadView() {
        let barButtonTemp = UIBarButtonItem(title: "Fº", style: .plain, target: self, action: #selector(tapNavTemp))
        let batButtonMap = UIBarButtonItem(image: UIImage(named: "map"), style: .plain, target: self, action: #selector(tapNavMap))
        navigationItem.rightBarButtonItems = [batButtonMap, barButtonTemp]
        view = baseView
    }
    
    @objc func tapNavTemp() {
        if navigationItem.rightBarButtonItems?[1].title == "Fº" {
            for i in 0 ..< viewModel.weathers.count {
                viewModel.weathers[i].main.temp = convertToFahrenheit(viewModel.weathers[i].main.temp ?? 0)
                viewModel.weathers[i].main.temp_min = convertToFahrenheit(viewModel.weathers[i].main.temp_min ?? 0)
                viewModel.weathers[i].main.temp_max = convertToFahrenheit(viewModel.weathers[i].main.temp_max ?? 0)
            }
            navigationItem.rightBarButtonItems?[1].title = "Cº"
            baseView.tableView.reloadData()
        } else {
            for i in 0 ..< viewModel.weathers.count {
                viewModel.weathers[i].main.temp = convertToCelsius(viewModel.weathers[i].main.temp ?? 0)
                viewModel.weathers[i].main.temp_min = convertToCelsius(viewModel.weathers[i].main.temp_min ?? 0)
                viewModel.weathers[i].main.temp_max = convertToCelsius(viewModel.weathers[i].main.temp_max ?? 0)
            }
            navigationItem.rightBarButtonItems?[1].title = "Fº"
            baseView.tableView.reloadData()
        }
    }
        
    
    @objc func tapNavMap() {
        guard let titleBarButton = navigationItem.rightBarButtonItems?[1].title else { return }
        navigationController?.pushViewController(WeatherMapViewController(weathersList: viewModel.weathers, titleBarButton: titleBarButton), animated: false)
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
        cell.descriptionLabel.text = weathers.weather[0].description
        cell.temperatureLabel.text =  String(format: "%.f", weathers.main.temp ?? "") + "º"
        cell.temperatureMinLabel.text = "Min: " + String(format: "%.f", weathers.main.temp_min ?? "") + "º"
        cell.temperatureMaxLabel.text = "Max: " + String(format: "%.f", weathers.main.temp_max ?? "") + "º"

        guard let icon = weathers.weather[0].icon else { return cell }
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
        
        return cell
    }
}




