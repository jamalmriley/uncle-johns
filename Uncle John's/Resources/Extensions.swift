//
//  Extensions.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/23/22.
//

import Foundation
import SwiftUI

extension Color {
    static let restaurantTheme = RestaurantColorTheme()
    static let genericTheme = GenericColorTheme()
    static let suffixArray = ["(DD)", "(UJB)"]
}

struct RestaurantColorTheme {
    @EnvironmentObject var restaurantModel: RestaurantModel
    let colorSchemeSuffix = ["(DD)", "(UJB)"]
    
    var accent: Color { return Color("AccentColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])") }
    var background: Color { return Color("BackgroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])") }
    var foreground: Color { return Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])") }
    var invertedForeground: Color { return Color("InvertedForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])") }
    var secondary: Color { return Color("SecondaryColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])") }
    var tertiary: Color { return Color("TertiaryColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])") }
}

struct GenericColorTheme {
    let background = Color("BackgroundColor")
    let foreground = Color("ForegroundColor")
    let tertiary = Color("TertiaryColor")
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
