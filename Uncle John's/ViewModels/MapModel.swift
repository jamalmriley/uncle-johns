//
//  MapModel.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/4/22.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 41.87905212020726, longitude: -87.63589344400307) /// Defaults to Willis Tower coordinates for users who do not consent to Location-based permissions.
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) /// Default zoom level of map.
    static let closeUpSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

final class MapModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManager = CLLocationManager()
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
        }
        else {
            print("Location services are disabled.")
        }
    }
    
    private func checkLocationAuth() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("You're location is restricted, likely due to parental controls.") // TODO: Turn into alert
        case .denied:
            print("You're location is denied. Please go into your settings to change it.") // TODO: Turn into alert
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
}
