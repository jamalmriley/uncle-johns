//
//  Uncle_Johns.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/3/22.
//

import SwiftUI
import Firebase

@main
struct Uncle_Johns: App {
    
    init() {
        FirebaseApp.configure()
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
