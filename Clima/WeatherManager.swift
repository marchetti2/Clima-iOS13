//
//  WeatherManager.swift
//  Clima
//
//  Created by Eydde on 31/12/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=8628c8bed635920d25f99064e88127b7&lang=pt&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        getData(url: urlString)
    }
    
    func getData(url: String) {
        
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(data: safeData) {
                        delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, temperature: temp, cityName: name)
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
}

