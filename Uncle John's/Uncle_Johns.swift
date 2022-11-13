//
//  Uncle_Johns.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/3/22.
//

import SwiftUI
import Firebase
import Stripe

@main
struct Uncle_Johns: App {
    
    init() {
        FirebaseApp.configure()
        StripeAPI.defaultPublishableKey = "pk_test_51M3hPwFRvMWIpQXd6EArTaIrRjzoB2SfhJIudlhoFenwcgyeN9AOyra8DLPRI98UKq6O8xZkunUuduz0bS2QZB5700xxfHYapf"
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(AppSettingsModel())
                .environmentObject(AuthModel())
                .environmentObject(CartModel())
                .environmentObject(RestaurantModel())
                .environmentObject(ChatModel())
        }
    }
}
