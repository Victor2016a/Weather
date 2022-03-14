//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherTableViewCell"
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var iconWeatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var temperatureMinLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var temperatureMaxLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(cityLabel)
        contentView.addSubview(iconWeatherImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(temperatureMinLabel)
        contentView.addSubview(temperatureMaxLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cityLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            iconWeatherImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            iconWeatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconWeatherImage.bottomAnchor.constraint(equalTo: temperatureMinLabel.topAnchor),
            iconWeatherImage.heightAnchor.constraint(equalToConstant: 70),
            iconWeatherImage.widthAnchor.constraint(equalToConstant: 70),
            
            descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconWeatherImage.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: temperatureMinLabel.topAnchor),

            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            temperatureLabel.bottomAnchor.constraint(equalTo: temperatureMaxLabel.topAnchor),

            temperatureMinLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            temperatureMinLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            temperatureMinLabel.widthAnchor.constraint(equalToConstant: 100),
            temperatureMinLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            temperatureMaxLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            temperatureMaxLabel.leadingAnchor.constraint(equalTo: temperatureMinLabel.trailingAnchor),
            temperatureMaxLabel.widthAnchor.constraint(equalToConstant: 100),
            temperatureMaxLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
