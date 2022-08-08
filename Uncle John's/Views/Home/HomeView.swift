//
//  HomeView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")")
                .ignoresSafeArea()
            VStack {
                Header()
                    .environmentObject(CartModel())
                Spacer()
                ScrollView(showsIndicators: false) {
                    HomeTile(image: "BBQ", header: "Join Uncle John's Rewards!", description: "Get access to special discounts & deals, earn points toward free meals, and get a gift on your birthday!", buttonLabel: "Join now")
                    HomeTile()
                    HomeTile(image: "Ukraine", header: "We stand with Ukraine.", description: "We stand with Ukraine and are working to contribute aid and relief for its citizens.", buttonLabel: "Learn more")
                    HomeTile(image: "Chicago", header: "Refer a friend!", description: "Refer a friend to download our app and get $5 off! Up to 10 friends allowed.", buttonLabel: "Share")
                    HomeTile(image: "Hispanic Heritage Month", header: "Hispanic Heritage Month", description: "Join us in celebrating Hispanic Heritage Month! Learn more about its origin and ways you can help!", buttonLabel: "Learn more")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
