//
//  ViewController.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    var baseView = WeatherListView()
    private var viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadWeathersData()
        view = baseView
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

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return .init() }
        let weather = viewModel.cellForRow(at: indexPath)
        return cell
    }
    
}


