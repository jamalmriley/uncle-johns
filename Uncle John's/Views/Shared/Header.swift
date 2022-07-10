//
//  Header.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/10/22.
//

import SwiftUI

struct Header: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("ForegroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
                Spacer()
                Image(restaurantModel.selectedRestaurant == 0 ? "Dat Donut Header" : colorScheme == .light ? "Uncle John's Header (Light)" : "Uncle John's Header (Dark)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Spacer()
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("ForegroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .environmentObject(RestaurantModel())
            .colorScheme(.light)
    }
}
