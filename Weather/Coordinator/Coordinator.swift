//
//  Coordinator.swift
//  Weather
//
//  Created by Victor Vieira on 17/03/22.
//

import UIKit

enum Event {
  case listButtonNav(viewModel: [WeatherData], titleBarButton: String)
}

protocol Coordinator {
  var navigationController: UINavigationController? { get set }
  func eventOccurred(with type: Event)
  func start()
}

protocol Coordinating {
  var coordinator: Coordinator? { get set }
}
