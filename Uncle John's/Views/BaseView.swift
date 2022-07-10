//
//  BaseView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct BaseView: View {
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
                    
                    ScanView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .tag("qrcode")
                    
                    MenuView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .tag("takeoutbag.and.cup.and.straw")
                    
                    ProfileView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .tag("person.crop.circle")
                    
                }
                .ignoresSafeArea(.all, edges: [.horizontal])
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    // Save progress to database when the app is moving from active to background
                }
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color("TertiaryColor"))
                        .frame(height: 90)
                    HStack(alignment: .center, spacing: 0) {
                        TabButton(image: "house", dimension: 23, label: "Home")
                        TabButtonStatic(image: "qrcode", dimension: 23, label: "Earn Points")
                        TabButton(image: "takeoutbag.and.cup.and.straw", dimension: 23, label: "Order")
                        TabButton(image: "person.crop.circle", dimension: 23, label: "Profile")
                    }
                    .cornerRadius(25, corners: [.topLeft, .topRight])
                    .padding(.top, 15)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            .background(Color("BackgroundColor (UJB)"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    
    func TabButton(image: String, dimension: CGFloat, label: String) -> some View {
        Button {
            withAnimation {currentTab = image}
        } label: {
            VStack {
                Image(systemName: currentTab == image ? "\(image).fill" : image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: dimension, height: dimension)
                    .foregroundColor(currentTab == image ? Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")") : .gray)
                    .frame(maxWidth: .infinity)
                Text(label)
                    .foregroundColor(currentTab == image ? Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")") : .gray)
                    .font(.caption)
            }
        }
    }
    func TabButtonStatic(image: String, dimension: CGFloat, label: String) -> some View {
        Button {
            withAnimation {currentTab = image}
        } label: {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: dimension, height: dimension)
                    .foregroundColor(currentTab == image ? Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")") : .gray)
                    .frame(maxWidth: .infinity)
                Text(label)
                    .foregroundColor(currentTab == image ? Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")") : .gray)
                    .font(.caption)
            }
        }
    }
    func TabButtonImage(image: String, dimension: CGFloat, label: String) -> some View {
        Button {
            withAnimation {currentTab = image}
        } label: {
            VStack {
                Image("harolds_h")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: dimension, height: dimension)
                    .foregroundColor(currentTab == image ? Color("AccentColor1") : .gray)
                    .frame(maxWidth: .infinity)
                Text(label)
                    .foregroundColor(Color("ForegroundColor"))
                    .font(.caption)
            }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
