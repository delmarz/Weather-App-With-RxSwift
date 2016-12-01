//
//  DarkSkyWeatherModel.swift
//  RXSwift Weather
//
//  Created by Israel Mayor on 30/11/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import Foundation

struct DarkSkyWeatherModel {
    var numberDays = 0
    private var _summary: String!
    private var _humidity: Double!
    private var _windSpeed: Double!
    
    var summary: String {
        if _summary == nil {
            return ""
        }
        return _summary
    }
    
    var humidity: Double {
        if _humidity == nil {
            return 0
        }
        return _humidity
    }
    
    var windSpeed: Double {
        if _windSpeed == nil {
            return 0
        }
        return _windSpeed
    }
    
    init(data: JSONDictionary) {
        if let summary = data["summary"] as? String {
            _summary = summary
        }
        if let humidity = data["humidity"] as? Double {
            _humidity = humidity
        }
        if let windSpeed = data["windSpeed"] as? Double {
            _windSpeed = windSpeed
        }
    }
}
