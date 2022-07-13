//
//  Uncle_Johns.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/3/22.
//

import SwiftUI

@main
struct Uncle_Johns: App {
    var body: some Scene {
        WindowGroup {
            BaseView()
                .environmentObject(RestaurantModel())
                .environmentObject(AppSettingsModel())
        }
    }
}
