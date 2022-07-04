//
//  ContentView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State private var isExpanded = false
    private var restaurantIcons = ["circle.circle", "smoke"]
    private var colorSchemeSuffix = ["(DD)", "(UJB)"]
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                
                Text("Menu")
                    .font(.custom("AvenirNext-Bold", size: 32))
                    .textCase(.uppercase)
                    .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                
                Spacer()
                Picker("Picker", selection: $restaurantModel.selectedRestaurant) {
                    ForEach(0..<restaurantModel.restaurants.count, id: \.self) { index in
                        Image(systemName: restaurantIcons[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 125)
                
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color("BackgroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .colorScheme(.dark)
            .environmentObject(RestaurantModel())
        
        ContentView()
            .colorScheme(.light)
            .environmentObject(RestaurantModel())
    }
}
