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

struct HomeTile: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var image: String = "Chicago"
    var header: String = "Up the ACCESS."
    var description: String = "Learn more about the Chicago ACCESS Initative and what it's doing for Chicago's South Side."
    var buttonLabel: String = "Learn more"
    
    var body: some View {
        ZStack (alignment: .bottom) {
            ZStack {
                Rectangle()
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350)
                
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.4)
            }
            .frame(height: 350)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .background(.thinMaterial)
                    .frame(height: 140)
                
                VStack (alignment: .leading) {
                    // Learn more about the Chicago ACCESS Initative, an initiative dedicated to provide more and better eating and food awareness to Chicago's south side.
                    // Achieving Comfortable and Consummate Eating for the South Side
                    Text(header)
                        .font(.custom("AvenirNext-Bold", size: 20))
                    Text(description)
                        .font(.custom("AvenirNext-Medium", size: 14))
                    
                    Button {
                        //
                    } label: {
                        ZStack {
                            Capsule()
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
                            Text(buttonLabel)
                                .font(.custom("AvenirNext-Medium", size: 16))
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal, 10)
            }
        }
        .frame(width: 350)
        .cornerRadius(10)
        .padding(.bottom)
    }
}
