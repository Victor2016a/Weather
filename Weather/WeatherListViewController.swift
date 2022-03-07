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
        configureTableView()
        loadWeathersData()
    }
    
    override func loadView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapNav))
        view = baseView
    }
    
    @objc func tapNav() {
        navigationController?.pushViewController(WeatherMapViewController(), animated: false)
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
        let weathes = viewModel.cellForRow(at: indexPath)
        cell.cityLabel.text = weathes.name
        cell.descriptionLabel.text = weathes.weather[indexPath.row].description
        cell.temperatureLabel.text =  String(format: "%.f", weathes.main.temp ?? "") + "º"
        cell.temperatureMinLabel.text = "Min: " + String(format: "%.f", weathes.main.temp_min ?? "") + "º"
        cell.temperatureMaxLabel.text = "Max: " + String(format: "%.f", weathes.main.temp_max ?? "") + "º"
        
        guard let icon = weathes.weather[indexPath.row].icon else { return cell }
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




