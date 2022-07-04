//
//  Weather.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/4/22.
//

import Foundation

struct Response: Decodable {
    var coord: Coord
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
}

struct Coord: Decodable {
    var lat: Double
    var lon: Double
}

struct Weather: Decodable {
    var id: Double
    var main: String
    var description: String
    var icon: String
}

struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
}

struct Wind: Decodable {
    var speed: Double
    var deg: Double
    var gust: Double
}

struct Clouds: Decodable {
    var all: Int
}

struct Sys: Decodable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
}
