//
//  WeatherModel.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/4/22.
//

import Foundation
import CoreLocation

enum WeatherAPICreds {
    static let apiKey = "727b45bf8760b5807a8376e5b36b63b0"
}

class WeatherModel: ObservableObject {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> Response {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(WeatherAPICreds.apiKey)&units=imperial") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data.")
        }
        
        let decodedData = try JSONDecoder().decode(Response.self, from: data)
        
        return decodedData
    }
    
    func getCurrentCityWeather() async throws -> Response {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Chicago&appid=\(WeatherAPICreds.apiKey)") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data.")
        }
        
        let decodedData = try JSONDecoder().decode(Response.self, from: data)
        
        return decodedData
    }
}
