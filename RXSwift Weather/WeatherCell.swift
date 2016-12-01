//
//  WeatherCell.swift
//  RXSwift Weather
//
//  Created by Israel Mayor on 01/12/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    var weather: DarkSkyWeatherModel? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var weatheStatusLabel: UILabel!
    @IBOutlet weak var weatherHumidityLabel: UILabel!
    @IBOutlet weak var weatherWindSpeedLabel: UILabel!
    
    
    func updateUI() {
        weatheStatusLabel.text = "Day \(weather!.numberDays): \(weather!.summary)"
        weatherHumidityLabel.text = "\(weather!.humidity) "
        weatherWindSpeedLabel.text = "\(weather!.windSpeed) SI"
    }
}
