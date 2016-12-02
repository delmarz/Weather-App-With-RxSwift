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
    var timeZone = ""
    private var _summary: String!
    private var _dewPoint: Double!
    private var _windSpeed: Double!
    private var _icon: String!
    
    var summary: String {
        if _summary == nil {
            return ""
        }
        return _summary
    }
    
    var dewPoint: Double {
        if _dewPoint == nil {
            return 0
        }
        return _dewPoint
    }
    
    var windSpeed: Double {
        if _windSpeed == nil {
            return 0
        }
        return _windSpeed
    }
    
    var icon: String {
        if _icon == nil {
            return ""
        }
        return _icon
    }
    
    init(data: JSONDictionary) {
        if let summary = data["summary"] as? String {
            _summary = summary
        }
        if let dewPoint = data["dewPoint"] as? Double {
            _dewPoint = dewPoint
        }
        if let windSpeed = data["windSpeed"] as? Double {
            _windSpeed = windSpeed
        }
        if let icon = data["icon"] as? String {
            _icon = icon
        }
    }
}
