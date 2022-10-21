//
//  ProfileView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI
import Firebase
import LocalAuthentication

struct ProfileView: View {
    @EnvironmentObject var authModel: AuthModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var cartModel: CartModel
    @StateObject var settings: AppSettingsModel = AppSettingsModel()
    
    // Biometric Properties
    @AppStorage("use_biometrics") var useBiometrics: Bool = false
    
    // Keychain Properties
    @Keychain(key: "use_biometrics_email", account: "BiometricsLogin") var storedEmail
    @Keychain(key: "use_biometrics_password", account: "BiometricsLogin") var storedPassword
    
    // Login Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])")
                    .ignoresSafeArea()
                VStack {
                    Header()
                    
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
                                        .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                    
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
                                
                                EmojiButtons()
                                    .environmentObject(AppSettingsModel())
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
                            
                            ProfileMenuOption(menuOption: "Chat with Support", view: AnyView(ChatView()))
                            ProfileMenuOption(menuOption: "The Legal Stuff", view: AnyView(ComingSoonView()))
                            
                            HStack {
                                if useBiometrics {
                                    // Clear FaceID
                                    Button {
                                        useBiometrics = false
                                        storedEmail = nil
                                        storedPassword = nil
                                    } label: {
                                        ZStack {
                                            Capsule()
                                                .stroke(Color("ForegroundColor"), lineWidth: 2)
                                                .frame(width: 175, height: 50)
                                            
                                            HStack {
                                                Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                                    .resizable()
                                                    .renderingMode(.template)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25, height: 25)
                                                
                                                Text("Disable " + String(LAContext().biometryType == .faceID ? "Face ID" : "Touch ID"))
                                                    .font(.custom("AvenirNext-Medium", size: 16))
                                            }
                                            .foregroundColor(Color("ForegroundColor"))
                                        }
                                    }
                                }
                                if logStatus {
                                    Spacer()
                                    Button {
                                        try? Auth.auth().signOut()
                                        authModel.checkLogin()
                                    } label: {
                                        ZStack {
                                            Capsule()
                                                .frame(width: 150, height: 50)
                                                .foregroundColor(.red)
                                            
                                            HStack {
                                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                                Text("Log Out")
                                                    .font(.custom("AvenirNext-Medium", size: 18))
                                            }
                                        }
                                    }
                                    .buttonStyle(.plain)
                                    Spacer()
                                }
                            }
                            .padding(.vertical)
                            
                            HStack {
                                Spacer()
                                Text("v1.0")
                                    .font(.custom("AvenirNext-Medium", size: 13))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .padding(.bottom)
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
            .environmentObject(AuthModel())
            .environmentObject(RestaurantModel())
            .environmentObject(CartModel())
            .colorScheme(.dark)
    }
}

struct EmojiButtons: View {
    @EnvironmentObject var appSettingsModel: AppSettingsModel
    var emojis: [String] = ["👋", "👋🏻", "👋🏼", "👋🏽", "👋🏾", "👋🏿"]
    
    var body: some View {
        
        HStack(spacing: 0) {
            Spacer()
            ForEach(0..<emojis.count, id: \.self) { index in
                Button  {
                    appSettingsModel.emojiIndex = index
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(appSettingsModel.emojiIndex == index ? .white : .clear, lineWidth: 2)
                            .foregroundColor(.clear)
                            .frame(width: 50, height: 50)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                        Text(emojis[index])
                    }
                }
                Spacer()
            }
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
