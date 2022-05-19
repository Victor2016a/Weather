//
//  WeatherMapView.swift
//  Weather
//
//  Created by Victor Vieira on 09/03/22.
//

import UIKit
import MapKit

class WeatherMapView: UIView {
  var mapView: MKMapView = {
    let mapView = MKMapView()
    mapView.translatesAutoresizingMaskIntoConstraints = false
    return mapView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    backgroundColor = .white
    addSubview(mapView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
      mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
}
