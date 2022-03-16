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
        let barButtonMap = UIBarButtonItem(image: UIImage(named: "map"), style: .plain, target: self, action: #selector(tapNavMap))
        barButtonMap.isEnabled = false
        barButtonTemp.isEnabled = false
        navigationItem.rightBarButtonItems = [barButtonMap, barButtonTemp]
        view = baseView
    }
    
    @objc func tapNavTemp() {
        if navigationItem.rightBarButtonItems?[1].title == "Fº" {
            viewModel.convertAllTempToFahrenheit()
            navigationItem.rightBarButtonItems?[1].title = "Cº"
            baseView.tableView.reloadData()
        } else {
            viewModel.convertAllTempToCelsius()
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
            self?.baseView.spinner.stopAnimating()
            self?.navigationItem.rightBarButtonItems?[1].isEnabled = true
            self?.navigationItem.rightBarButtonItems?[0].isEnabled = true
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
        
        downloadImageFrom(url: url) { (image, error) in
            cell.iconWeatherImage.image = image
        }
        
        return cell
    }
}




