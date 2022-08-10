//
//  LaunchView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/10/22.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    // @EnvironmentObject var authModel: AuthModel
    // Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    // @Keychain(key: "use_biometrics_email", account: "BiometricsLogin") var storedEmail
    
    var body: some View {
        // Remove "!" below once biometry and login capabilities have been added.
        if !logStatus {
            
            // Detect the authorization status of geolocating the user
            if restaurantModel.authorizationState == .notDetermined {
                OnboardingView() // If location is not determined, show OnboardingView.
            }
            else if restaurantModel.authorizationState == .authorizedAlways || restaurantModel.authorizationState == .authorizedWhenInUse {
                // If approved, show the BaseView.
                BaseView()
                    .onAppear {
                        // Check login status and fetch user metadata.
//                        authModel.checkLogin()
//                        authModel.getUserData()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        // Save cart info and order progress
                        print("The user has left the app. Saving user data...")
                    }
            }
            else {
                // If denied, show LocationDeniedView.
                LocationDeniedView()
            }
        }
        else {
            NavigationView {
//                LoginView()
//                    .navigationBarHidden(true)
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .colorScheme(.dark)
            .environmentObject(RestaurantModel())
            //.environmentObject(AuthModel())
    }
}
