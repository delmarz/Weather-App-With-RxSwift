//
//  WeatherViewModel.swift
//  RXSwift Weather
//
//  Created by Israel Mayor on 30/11/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct WeatherViewModel {
    let disposeBag = DisposeBag()
    let searchText = Variable("")
    
    private let APIKey = "78b0e3c1f81df4938c1539c438febf53/"
    private let baseURL = "https://api.darksky.net/forecast/"
    
    var data: Driver<[DarkSkyWeatherModel]> {
        return searchText.asObservable()
            .throttle(0.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest({
                self.getStatusWeather(with: $0)
            })
            .asDriver(onErrorJustReturn: [])
    }
    
    func getStatusWeather(with latAndLong: String) -> Observable<[DarkSkyWeatherModel]> {
        guard !latAndLong.isEmpty,
            let url = URL(string: baseURL + APIKey + latAndLong) else {
                return Observable.just([])
        }
        
        return URLSession.shared
                    .rx.json(url: url)
                    .map({
                        var weatherArray = [DarkSkyWeatherModel]()
                        
                        if let root = $0 as? JSONDictionary,
                           let daily = root["daily"] as? JSONDictionary,
                           let data = daily["data"] as? JSONArray {

                            for (_, items) in data.enumerated() {
                                let weather = DarkSkyWeatherModel(data: items as! JSONDictionary)
                                weatherArray.append(weather)
                            }
                        }
                        return weatherArray
                    })

    }
}
