//
//  WeatherMapViewController.swift
//  Weather
//
//  Created by Victor Vieira on 07/03/22.
//

import UIKit
import MapKit

class WeatherMapViewController: UIViewController, MKMapViewDelegate {
    
    private var weathers: [WeatherData]
    private var titleBarButton: String
    private var pinsMap = [MKPointAnnotation]()
    private let baseView = WeatherMapView()
    
    init(weathersList: [WeatherData], titleBarButton: String) {
        self.weathers = weathersList
        self.titleBarButton = titleBarButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let barButtonTemp = UIBarButtonItem(title: titleBarButton, style: .plain, target: self, action: #selector(tapNavTemp))
        let batButtonMap = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(tapNavMap))
        navigationItem.rightBarButtonItems = [batButtonMap, barButtonTemp]
        navigationItem.hidesBackButton = true
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseView.mapView.delegate = self
        setupRegion()
        setupPins()
    }
    
    private func setupRegion() {
        guard let latitude = weathers[0].coord.lat else { return }
        guard let longitude = weathers[0].coord.lon else { return }
        
        baseView.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude , longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
    }
    
    private func setupPins() {
        for i in 0 ..< weathers.count {
            let pin = MKPointAnnotation()
            guard let latitude = weathers[i].coord.lat else { return }
            guard let longitude = weathers[i].coord.lon else { return }
            pin.coordinate = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
            pin.title = String(format: "%.f", weathers[i].main.temp ?? "") + "º"
            pinsMap.append(pin)
        }
        baseView.mapView.addAnnotations(pinsMap)
    }
    
    @objc func tapNavMap() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func tapNavTemp() {
        
        if navigationItem.rightBarButtonItems?[1].title == "Fº" {
            for i in 0 ..< weathers.count {
                guard let tempPin = pinsMap[i].title else { return }
                pinsMap[i].title = String(format: "%.f", convertToFahrenheit((tempPin as NSString).doubleValue)) + "º"
            }
            navigationItem.rightBarButtonItems?[1].title = "Cº"
        } else {
            for i in 0 ..< weathers.count {
                guard let tempPin = pinsMap[i].title else { return }
                pinsMap[i].title = String(format: "%.f", convertToCelsius((tempPin as NSString).doubleValue)) + "º"
            }
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
