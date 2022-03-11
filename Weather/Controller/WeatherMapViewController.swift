//
//  WeatherMapViewController.swift
//  Weather
//
//  Created by Victor Vieira on 07/03/22.
//

import UIKit
import MapKit

class WeatherMapViewController: UIViewController, MKMapViewDelegate, MKLocalSearchCompleterDelegate {
    
    private let weathers: WeatherData
    private let pin = MKPointAnnotation()
    private let baseView = WeatherMapView()
    
    init(weathersList: WeatherData) {
        self.weathers = weathersList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let barButtonTemp = UIBarButtonItem(title: "Fº", style: .plain, target: self, action: #selector(tapNavTemp))
        let batButtonMap = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(tapNavMap))
        navigationItem.rightBarButtonItems = [batButtonMap, barButtonTemp]
        navigationItem.hidesBackButton = true
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let map = self else { return }
                self?.pin.coordinate = location.coordinate
                self?.pin.title = String(format: "%.f", self?.weathers.main.temp ?? "") + "º"
                map.baseView.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)), animated: true)
                guard let pin = self?.pin else { return }
                map.baseView.mapView.addAnnotation(pin)
            }
        }
        self.baseView.mapView.delegate = self
    }
    
    @objc func tapNavMap() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func tapNavTemp() {
        if navigationItem.rightBarButtonItems?[1].title == "Fº" {
            guard let temp = weathers.main.temp else { return }
            pin.title = String(format: "%.f", convertToFahrenheit(temp)) + "º"
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
    
}
