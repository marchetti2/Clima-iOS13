//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchInputField: UITextField!
    
    var weaterManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weaterManager.delegate = self
        searchInputField.delegate = self
    }

    @IBAction func searchHandler(_ sender: Any) {
        searchInputField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchInputField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        textField.placeholder = "Type something"
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchInputField.text {
            weaterManager.fetchWeather(cityName: city)
        }
        
        searchInputField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
        print("oi")
    }

}

