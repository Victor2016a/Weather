//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Victor Vieira on 04/03/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherTableViewCell"
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var temperatureMinLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var temperatureMaxLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(cityLabel)
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
            
            descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: temperatureMinLabel.topAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: temperatureMaxLabel.topAnchor),
            
            temperatureMinLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            temperatureMinLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            temperatureMinLabel.trailingAnchor.constraint(equalTo: temperatureMaxLabel.leadingAnchor),
            temperatureMinLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            
            temperatureMaxLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            temperatureMaxLabel.leadingAnchor.constraint(equalTo: temperatureMinLabel.trailingAnchor),
            temperatureMaxLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            temperatureMaxLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
        ])
    }
}
