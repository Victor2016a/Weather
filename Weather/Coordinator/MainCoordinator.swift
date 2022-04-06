//
//  MainCoordinator.swift
//  Weather
//
//  Created by Victor Vieira on 17/03/22.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: Event) {
      switch type {
      case .listButtonNav(let weathersList, let titleBarButton):
        let viewController = WeatherMapViewController(weathersList: weathersList,
                                                      titleBarButton: titleBarButton)
        navigationController?.pushViewController(viewController, animated: false)
      }
    }
  
    func start() {
      var viewControllerList: UIViewController & Coordinating = WeatherListViewController()
        viewControllerList.coordinator = self
        navigationController?.setViewControllers([viewControllerList], animated: false)
    }
}
