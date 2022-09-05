//
//  DirectionsMap.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/1/22.
//

import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable {
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var mapModel: MapModel
    @EnvironmentObject var appSettingsModel: AppSettingsModel
    
    var start: CLLocationCoordinate2D {
        return mapModel.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 41.744130, longitude: -87.604630) // Uncle John's Barbeque restaurant coordinates
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        // Create map
        let map = MKMapView()
        map.delegate = context.coordinator
        
        // Create directions request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        // Show the user location
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        
        // Create directions object
        let directions = MKDirections(request: request)
        
        // Calculate route
        directions.calculate { (response, error) in
            
            if error == nil && response != nil {
                
                // Plot the route on the map
                for route in response!.routes {
                    
                    map.addOverlay(route.polyline)
                    
                    // Zoom into the region
                    map.setVisibleMapRect(route.polyline.boundingMapRect,
                                          edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50),
                                          animated: true)
                    
                    restaurantModel.routeDistance = route.distance
                    restaurantModel.routeETA = route.expectedTravelTime
                }
            }
        }
        
        // Place annotation on the end point
        let annotation = MKPointAnnotation()
        annotation.coordinate = end
        annotation.title = restaurantModel.restaurants[restaurantModel.selectedRestaurant].nickname
        map.addAnnotation(annotation)
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    
    // MARK: - Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = UIColor(Color.blue)
            renderer.lineWidth = 5
            return renderer
        }
    }
}
