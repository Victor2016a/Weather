//
//  WeatherMapViewController.swift
//  Weather
//
//  Created by Victor Vieira on 07/03/22.
//

import UIKit
import MapKit

class WeatherMapViewController: UIViewController, MKMapViewDelegate {
    
    private let weathers: WeatherData
    private let pin = MKPointAnnotation()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    init(weathersList: WeatherData) {
        self.weathers = weathersList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mapView)
        setupConstraints()
        
        let barButtonTemp = UIBarButtonItem(title: "Fº", style: .plain, target: self, action: #selector(tapNavTemp))
        let batButtonMap = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(tapNav))
        navigationItem.rightBarButtonItems = [batButtonMap, barButtonTemp]
        
        navigationItem.hidesBackButton = true
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let map = self else { return }
                self?.pin.coordinate = location.coordinate
                self?.pin.title = String(format: "%.f", self?.weathers.main.temp ?? "") + "º"
                map.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)), animated: true)
                guard let pin = self?.pin else { return }
                map.mapView.addAnnotation(pin)
            }
        }
        
        self.mapView.delegate = self
    }
    
    
    @objc func tapNav() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func tapNavTemp() {
        if navigationItem.rightBarButtonItems?[1].title == "Fº" {
            guard let temp = weathers.main.temp else { return }
            pin.title = String(format: "%.f", convertTemperature(temp)) + "º"
            navigationItem.rightBarButtonItems?[1].title = "Cº"
        } else {
            pin.title = String(format: "%.f", weathers.main.temp ?? "") + "º"
            navigationItem.rightBarButtonItems?[1].title = "Fº"
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationMap")
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
