//
//  RestaurantModel.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/4/22.
//

import Foundation
import CoreLocation
import MapKit

class RestaurantModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.87906809663624, longitude: -87.63592563051094),
                                                                   span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//    @Published private var userTrackingMode: MapUserTrackingMode = .follow // TODO: Allow user to disable
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    @Published var restaurants = [Restaurant]()
    @Published var placemark: CLPlacemark?
    
    @Published var isDirectionsShowing = false
    @Published var selectedRestaurant = 0
    @Published var showMenuItemCustomization: Bool = false
    @Published var showRestaurantPopUpCard = false
    
    @Published var routeDistance: Double = 0
    @Published var routeETA: Double = 0
    
    override init() {
        
        // Initializes NSObject
        super.init()
        self.restaurants = getLocalData()
        
        // Set ContentModel as the delegate of the location manager
        locationManager.delegate = self
        
    }
    
    // Parse local JSON file
    func getLocalData() -> [Restaurant] {
        
        // Get a URL path to the JSON file
        let pathString = Bundle.main.path(forResource: "restaurants", ofType: "json")
        
        // Check if pathString is not nil, otherwise (else)...
        guard pathString != nil else {
            return [Restaurant]()
        }
        
        // Create a URL object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Create a data object
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                let restaurantData = try decoder.decode([Restaurant].self, from: data)
                
                // Add the unique IDs
                for r in restaurantData {
                    r.id = UUID()
                }
                
                // Return the recipes
                return restaurantData
            }
            catch {
                // Error with parsing JSON data
                print(error)
            }
            
        }
        catch {
            // Error with retrieving data
            print(error)
        }
        
        return [Restaurant]()
    }
    
    func requestGeolocationPermission() {
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocating the user after we get permission
            locationManager.startUpdatingLocation()
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                                           span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
        else if locationManager.authorizationStatus == .denied {
            // We do not have permission
        }
    }
}
