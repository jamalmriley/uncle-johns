//
//  ProfileView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")")
                .ignoresSafeArea()
            VStack {
                Header()
                Spacer()
                ScrollView(showsIndicators: false) {
                    Text("Profile")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
