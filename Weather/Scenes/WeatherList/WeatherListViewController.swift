//
//  ViewController.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import UIKit

class WeatherListViewController: UIViewController, Coordinating {
  var coordinator: Coordinator?

  private var baseView = WeatherListView()
  private var viewModel = WeatherListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationItem()
    loadWeathersData()
    configureTableView()
  }
  
  override func loadView() {
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
  private func configureNavigationItem() {
    let barButtonTemp = UIBarButtonItem(title: "Fº", style: .plain, target: self, action: #selector(tapNavTemp))
    let barButtonMap = UIBarButtonItem(image: UIImage(named: "map"), style: .plain, target: self, action: #selector(tapNavMap))
    barButtonMap.isEnabled = false
    barButtonTemp.isEnabled = false
    navigationItem.rightBarButtonItems = [barButtonMap, barButtonTemp]
  }
  
  @objc func tapNavMap() {
    guard let titleBarButton = navigationItem.rightBarButtonItems?[1].title else { return }
    coordinator?.eventOccurred(with: .listButtonNav(viewModel: viewModel.weathers,
                                                    titleBarButton: titleBarButton))
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
    
    let viewModel = viewModel.cellForRow(at: indexPath)
    
    cell.configure(viewModel: viewModel)
    
    guard let url = URL(string: "https://openweathermap.org/img/wn/\(viewModel.icon)@2x.png") else { return cell }
    
    ImageProvider.shared.fecthImage(url: url, icon: viewModel.icon) { image in
      cell.iconWeatherImage.image = image
    }
    return cell
  }
}




