//
//  ProfileView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @StateObject var settings: AppSettingsModel = AppSettingsModel()
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
                                    .frame(width: reader.size.width - 50, height: 20)
                                    .foregroundColor(.black)
                                
                                ZStack(alignment: .trailing) {
                                    Capsule()
                                        .frame(width: (reader.size.width - 50) * (773/1000), height: 20)
                                        .foregroundColor(Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
                                    
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 25, height: 25)
                                }
                            }
                            
                            HStack {
                                Text("0")
                                    .frame(width: 50, alignment: .leading)
                                Spacer()
                                Text("250")
                                    .frame(width: 50)
                                Spacer()
                                Text("500")
                                    .frame(width: 50)
                                Spacer()
                                Text("750")
                                    .frame(width: 50)
                                Spacer()
                                Text("1,000")
                                    .frame(width: 50, alignment: .trailing)
                            }
                            .font(.custom("AvenirNext-Bold", size: 14))
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
                            
                            // MARK: - Profile Menu Options
                            ProfileMenuOption(menuOption: "Payment Methods", view: AnyView(ComingSoonView()))
                            ProfileMenuOption(menuOption: "Recent Orders", view: AnyView(ComingSoonView()))
                            ProfileMenuOption(menuOption: "Gift Cards", view: AnyView(ComingSoonView()))
                            
                            ProfileMenuOption(menuOption: "App Settings", view: AnyView(
                                SettingsView()
                                .navigationBarTitleDisplayMode(.inline)
                                .environmentObject(settings))
                            )
                            
                            ProfileMenuOption(menuOption: "Support", view: AnyView(ComingSoonView()))
                            ProfileMenuOption(menuOption: "The Legal Stuff", view: AnyView(ComingSoonView()))
                            
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

struct ProfileMenuOption: View {
    var menuOption: String
    var view: AnyView
    
    var body: some View {
        
        NavigationLink {
            view
        } label: {
            HStack {
                Text(menuOption)
                Spacer()
                Text("〉")
            }
            .font(.custom("AvenirNext-Bold", size: 20))
            .textCase(.uppercase)
            .foregroundColor(.white) // Just black or white depending on light/dark mode
        }
        
        Divider()
    }
}
