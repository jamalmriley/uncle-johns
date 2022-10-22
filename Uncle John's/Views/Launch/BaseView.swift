//
//  BaseView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct BaseView: View {
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State var currentTab = "house"
    
    // Hide native tab bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TabView(selection: $currentTab) {
                    
                    HomeView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .tag("house")
                    
                    RewardsView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .tag("app.gift")
                    
                    MenuView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .tag("takeoutbag.and.cup.and.straw")
                    
                    ProfileView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .tag("person.crop.circle")
                    
                }
                //                .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea(.all, edges: [.horizontal])
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    // Save progress to database when the app is moving from active to background
                }
                
                Divider()
                
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.2)
                        .frame(height: 85)
                    HStack(alignment: .center, spacing: 0) {
                        TabButtonV2(image: "house", dimension: 23, label: "Home")
                        TabButtonV2(image: "app.gift", dimension: 23, label: "Rewards")
                        TabButtonOrder(image: "takeoutbag.and.cup.and.straw", dimension: 23, label: "Order")
                        TabButtonV2(image: "person.crop.circle", dimension: 23, label: "Profile")
                    }
                    .padding(.top, 10)
                    //.background(.ultraThinMaterial)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            .background(Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
            .navigationTitle("Back")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    
    func TabButtonV2(image: String, dimension: CGFloat, label: String) -> some View {
        Button {
            withAnimation {currentTab = image}
        } label: {
            VStack {
                ZStack(alignment: .bottom) {
                    Image(systemName: currentTab == image ? "\(image).fill" : image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: dimension, height: dimension)
                        .foregroundColor(currentTab == image ? Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])") : .gray)
                        .frame(maxWidth: .infinity)
                    
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 10, height: 10)
                        .padding([.bottom, .leading], 15)
                        .opacity(0) // MARK: Use for unseen notifications/updates on respective page.
                }
                
                Text(label)
                    .foregroundColor(currentTab == image ? Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])") : .gray)
                    .font(.custom("AvenirNext-Medium", size: 13))
            }
        }
    }
    func TabButtonOrder(image: String, dimension: CGFloat, label: String) -> some View {
        Button {
            withAnimation {currentTab = image}
        } label: {
            VStack {
                ZStack(alignment: .bottom) {
                    Image(systemName: currentTab == image ? "\(image).fill" : image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: dimension, height: dimension)
                        .foregroundColor(currentTab == image ? Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])") : .gray)
                        .frame(maxWidth: .infinity)
                    
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 10, height: 10)
                        .padding([.bottom, .leading], 15)
                        .opacity(cartModel.menuItems.count > 0 ? 1 : 0)
                    
                }
                
                Text(label)
                    .foregroundColor(currentTab == image ? Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])") : .gray)
                    .font(.custom("AvenirNext-Medium", size: 13))
            }
        }
    }
}

struct UpdateIcon: View {
    @State var animate = false
    
    var body: some View {
        ZStack {
            Circle().fill(Color.red.opacity(0.25)).frame(width: 15, height: 15).scaleEffect(self.animate ? 1 : 0)
            Circle().fill(Color.red.opacity(0.35)).frame(width: 13, height: 13).scaleEffect(self.animate ? 1 : 0)
            Circle().fill(Color.red.opacity(0.45)).frame(width: 12, height: 12).scaleEffect(self.animate ? 1 : 0)
            Circle().fill(Color.red.opacity(1.00)).frame(width: 10, height: 10)
        }
        .onAppear {
            self.animate.toggle()
        }
        .animation(.linear(duration: 1.5).repeatForever(autoreverses: true))
        .frame(width: 15, height: 15)
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
        
        UpdateIcon()
    }
}
