//
//  ProfileView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var colorSchemeSuffix = ["(DD)", "(UJB)"]
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Color("BackgroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")")
                    .ignoresSafeArea()
                VStack {
                    Header()
                        .environmentObject(CartModel())
                    Spacer()
                    
                    Text("Hi, Jamal")
                        .font(.custom("AvenirNext-Bold", size: 32))
                        .padding(.bottom)
                    
                    // MARK: - Points Progress
                    Group {
                        Text("You have 773 points!")
                            .font(.custom("AvenirNext-Medium", size: 20))
                        
                        Text("227 points 'til your next reward!")
                            .font(.custom("AvenirNext-Medium", size: 16))
                        
                        // MARK: Points Progress Bar
                        VStack {
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .frame(width: reader.size.width - 50)
                                    .foregroundColor(.black)
                                
                                Capsule()
                                    .frame(width: (reader.size.width - 50) * (773/1000))
                                    .foregroundColor(Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
                                
                                /* HStack {
                                 ForEach(0..<9) { index in
                                 Spacer()
                                 Rectangle()
                                 .frame(width: 2)
                                 }
                                 Spacer()
                                 }
                                 .frame(width: reader.size.width - 50) */
                            }
                            .frame(height: 20)
                            
                            HStack {
                                Text("0")
                                Spacer()
                                Text("1,000")
                            }
                            .font(.custom("AvenirNext-Medium", size: 16))
                            .frame(width: reader.size.width - 50)
                        }
                    }
                    Divider()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            
                            // MARK: Skin Tone
                            Group {
                                Text("Skin Tone")
                                    .font(.custom("AvenirNext-Bold", size: 20))
                                    .textCase(.uppercase)
                                    .foregroundColor(.white) // Just black or white depending on light/dark mode
                                
                                HStack {
                                    Spacer()
                                    EmojiButton()
                                    EmojiButton(emoji: "👋🏻")
                                    EmojiButton(emoji: "👋🏼")
                                    EmojiButton(emoji: "👋🏽")
                                    EmojiButton(emoji: "👋🏾")
                                    EmojiButton(emoji: "👋🏿")
                                    Spacer()
                                }
                                .padding(.bottom)
                                
                                Divider()
                            }
                            
                            // MARK: Payment Methods
                            Group {
                                HStack {
                                    Text("Payment Methods")
                                    Spacer()
                                    Text("〉")
                                }
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .textCase(.uppercase)
                                .foregroundColor(.white) // Just black or white depending on light/dark mode
                                
                                Divider()
                            }
                            
                            // MARK: Recent Orders
                            Group {
                                HStack {
                                    Text("Recent Orders")
                                    Spacer()
                                    Text("〉")
                                }
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .textCase(.uppercase)
                                .foregroundColor(.white) // Just black or white depending on light/dark mode
                                
                                Divider()
                            }
                            
                            // MARK: Gift Cards
                            Group {
                                HStack {
                                    Text("Gift Cards")
                                    Spacer()
                                    Text("〉")
                                }
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .textCase(.uppercase)
                                .foregroundColor(.white) // Just black or white depending on light/dark mode
                                
                                Divider()
                            }
                            
                            // MARK: App Settings
                            Group {
                                HStack {
                                    Text("App Settings")
                                    Spacer()
                                    Text("〉")
                                }
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .textCase(.uppercase)
                                .foregroundColor(.white) // Just black or white depending on light/dark mode
                                
                                Divider()
                            }
                            
                            // MARK: Support
                            Group {
                                HStack {
                                    Text("Support")
                                    Spacer()
                                    Text("〉")
                                }
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .textCase(.uppercase)
                                .foregroundColor(.white) // Just black or white depending on light/dark mode
                                
                                Divider()
                            }
                            
                            // MARK: The Legal Stuff
                            Group {
                                HStack {
                                    Text("The Legal Stuff")
                                    Spacer()
                                    Text("〉")
                                }
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .textCase(.uppercase)
                                .foregroundColor(.white) // Just black or white depending on light/dark mode
                                
                                Divider()
                            }
                            
                            HStack {
                                Spacer()
                                Text("v1.0")
                                    .font(.custom("AvenirNext-Medium", size: 13))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
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

struct EmojiButton: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var colorSchemeSuffix = ["(DD)", "(UJB)"]
    var emoji: String = "👋"
    
    var body: some View {
        Button  {
            //
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.black)
                Text(emoji)
            }
            //            .overlay(
            //                RoundedRectangle(cornerRadius: 10)
            //                    .stroke(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"), lineWidth: 3)
            //                    .frame(width: 60, height: 60)
            //            )
        }
    }
}
