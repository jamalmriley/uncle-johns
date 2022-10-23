//
//  OrderConfirmedView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/22/22.
//

import SwiftUI

struct OrderConfirmedView: View {
    @EnvironmentObject var appSettingsModel: AppSettingsModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    var emojis: [String] = ["👍", "👍🏻", "👍🏼", "👍🏽", "👍🏾", "👍🏿"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Thanks for your order!")
                .font(.custom("AvenirNext-Bold", size: 32))
                .padding(.bottom)
            
            Text("We've got it from here, Jamal.")
                .font(.custom("AvenirNext-Medium", size: 20))
            
            Text("Good stuff is in the works! \(emojis[appSettingsModel.emojiIndex])")
                .font(.custom("AvenirNext-Medium", size: 20))
            
            Spacer()
            
            HStack {
                Spacer()
                VStack {
                    Text("Estimated Pickup Time")
                        .font(.custom("AvenirNext-Medium", size: 20))
                    Text("10:00 PM")
                        .font(.custom("AvenirNext-Bold", size: 24))
                }
                Spacer()
            }
            
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 10)
                        .foregroundColor(Color("LightGray"))
                    
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 25, height: 25)
                            
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                                .opacity(1) // TODO: Make based on order status variable
                        }
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 25, height: 25)
                            
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                                .opacity(1) // TODO: Make based on order status variable
                        }
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 25, height: 25)
                            
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                                .opacity(1) // TODO: Make based on order status variable
                        }
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 25, height: 25)
                            
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                                .opacity(0) // TODO: Make based on order status variable
                        }
                    }
                    .foregroundColor(.white)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 350/3 * 2 - 5, height: 6)
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .padding(.leading, 5)
                        
                        Spacer()
                    }
                }
                HStack(spacing: 0) {
                    Text("Received")
                        .frame(alignment: .leading)
                    
                    Spacer()
                    Text("Preparing...")
                        .frame(width: 65, alignment: .center)
                    Spacer()
                    Text("Cooking...")
                        .frame(width: 65, alignment: .center)
                    Spacer()
                    Text("Ready!")
                        .frame(alignment: .trailing)
                }
                .font(.custom("AvenirNext-Medium", size: 12))
            }
            .padding(.bottom)
            
//            HStack {
//                Spacer()
//                Text("Check back later for updates!")
//                    .font(.custom("AvenirNext-Medium", size: 16))
//                Spacer()
//            }
        }
        .padding(.horizontal)
        .background(Color("BackgroundColor (\(restaurantModel.selectedRestaurant == 0 ? "DD" : "UJB"))"))
    }
}

struct OrderConfirmedView_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmedView()
            .environmentObject(AppSettingsModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
