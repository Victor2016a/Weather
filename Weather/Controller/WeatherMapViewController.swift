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
        let batButtonMap = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(tapNav))
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
                map.baseView.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)), animated: true)
                guard let pin = self?.pin else { return }
                map.baseView.mapView.addAnnotation(pin)
            }
        }
        self.baseView.mapView.delegate = self
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
        
        guard let icon = weathers.weather[0].icon else { return annotationView }
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else { return annotationView }

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
                let imageWeather = UIImageView(image: image)
                imageWeather.translatesAutoresizingMaskIntoConstraints = false
                imageWeather.widthAnchor.constraint(equalToConstant: 50).isActive = true
                imageWeather.heightAnchor.constraint(equalToConstant: 50).isActive = true
                annotationView.leftCalloutAccessoryView = imageWeather
            }
        }

        }.resume()
        
        return annotationView
    }
    
}
