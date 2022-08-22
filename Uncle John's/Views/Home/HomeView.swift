//
//  HomeView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    @Environment(\.colorScheme) var colorScheme
    var colorSchemeSuffix = ["(DD)", "(UJB)"]
    private var emojis = ["🍩", "🍖"]
    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .top) {
                Color("BackgroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")")
                    .ignoresSafeArea()
                
                if restaurantModel.selectedRestaurant == 0 {
                    DonutGrid(width: reader.size.width, height: 180, cornerRadius: 30)
                        .ignoresSafeArea(.all, edges: .all)
                } else if restaurantModel.selectedRestaurant == 1 {
                    FireGrid(width: reader.size.width, height: 180, cornerRadius: 30)
                        .ignoresSafeArea(.all, edges: .all)
                }
                
                VStack(alignment: .leading) {
                    
                    // MARK: - Custom Header
                    VStack {
                        HStack {
                            CustomSegmentedControl(selection: $restaurantModel.selectedRestaurant, options: emojis, width: 90, fontSize: 16)
                            
                            Spacer()
                            
                            NavigationLink {
                                CartView()
                                    .environmentObject(cartModel)
                            } label: {
                                CartButton(numOfMenuItems: cartModel.menuItems.count)
                            }
                            .disabled(cartModel.menuItems.count <= 0)
                        }
                        .overlay {
                            Image(restaurantModel.selectedRestaurant == 0 ? "Dat Donut Header" : "Uncle John's Header (Light)")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                    
                    Text("Welcome, Jamal!")
                        .font(.custom("AvenirNext-Bold", size: 30))
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                    ScrollView(showsIndicators: false) {
                        
                        // MARK: - Support Our Friends!
                        Section(header: Text("Support Our Friends!").font(.custom("AvenirNext-Bold", size: 24))
                            .textCase(.uppercase)
                            .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                            .padding(.bottom, -10)) {
                            let blackOwnedBusinesses = ["Batter & Berries", "Chicago's Home of Chicken & Waffles", "ETA Creative Arts Foundation", "Hyde Park Hair Salon", "Kiwi's Boutique"]
                            
                            // Minority- and women-owned businesses are the backbone and heart of Chicago. Support them by checking them out below!
                            // Want to feature your business in our app? Contact us by clicking "Support" in the "Profile" tab.
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0..<4) { index in
                                        VStack {
                                            ZStack(alignment: .bottom) {
                                                Image("bob\(index + 1)")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                
                                                HStack {
                                                    Text("Learn More")
                                                        .font(.custom("AvenirNext-Medium", size: 18))
                                                    Spacer()
                                                }
                                                .padding(.horizontal)
                                                .frame(width: 200, height: 35)
                                                .background(Color("TertiaryColor").opacity(0.75))
                                            }
                                            .frame(width: 200, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            
                                            Text(blackOwnedBusinesses[index])
                                                .font(.custom("AvenirNext-Bold", size: 18))
                                                .multilineTextAlignment(.center)
                                                .frame(width: 200, height: 50, alignment: .top)
                                                .padding(.top, 5)
                                        }
                                        .frame(width: 210)
                                    }
                                }
                                .padding([.horizontal, .bottom])
                            }
                        }
                        .padding(.top)
                        
                        // MARK: - Upcoming Local Events
                        Section(header: Text("Upcoming Local Events")
                            .font(.custom("AvenirNext-Bold", size: 24))
                            .textCase(.uppercase)
                            .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                            .padding(.bottom, -50)) {
                            
                            // Want to feature your local event in our app? Contact us by clicking "Support" in the "Profile" tab.
                            EventCards()
                        }
                        
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
