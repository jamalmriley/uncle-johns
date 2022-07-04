//
//  MenuView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/3/22.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State private var selectedSubMenu = 0
    private var colorSchemeSuffix = ["(DD)", "(UJB)"]
    private var emojis = ["🍩", "🍖"]
    private var menuCategories = [["Food","Beverages"], ["Lunch & Dinner", "Catering"]]
    
    var body: some View {
        VStack {
            
            // MARK: Header and Picker
            HStack(alignment: .center) {
                
                Text("Menu")
                    .font(.custom("AvenirNext-Bold", size: 32))
                    .textCase(.uppercase)
                    .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                
                Spacer()
                Picker("Picker", selection: $restaurantModel.selectedRestaurant) {
                    ForEach(0..<restaurantModel.restaurants.count, id: \.self) { index in
                        Text(emojis[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                
            }
            
            Picker("Picker", selection: $selectedSubMenu) {
                ForEach(0..<menuCategories[restaurantModel.selectedRestaurant].count, id: \.self) { index in
                    Text(menuCategories[restaurantModel.selectedRestaurant][index])
                        .tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // MARK: Scrollable Menu
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("BackgroundSecondaryColor"))
                
                ScrollView(showsIndicators: false) {
                    VStack (alignment: .leading, spacing: 10) {
                        if restaurantModel.selectedRestaurant == 0 && selectedSubMenu == 0 {
                            ForEach(0..<restaurantModel.restaurants[restaurantModel.selectedRestaurant].foodItems.count, id: \.self) { index in
                                HStack (alignment: .top) {
                                    if restaurantModel.restaurants[restaurantModel.selectedRestaurant].foodItems[index].quantity > 0 {
                                        Text("(\(restaurantModel.restaurants[restaurantModel.selectedRestaurant].foodItems[index].quantity))")
                                            .font(.custom("AvenirNext-Bold", size: 18))
                                    }
                                    Text(restaurantModel.restaurants[restaurantModel.selectedRestaurant].foodItems[index].name)
                                    Spacer()
                                    Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].foodItems[index].price))")
                                        .font(.custom("AvenirNext-Bold", size: 18))
                                }
                                
                                if restaurantModel.restaurants[restaurantModel.selectedRestaurant].foodItems[index].addOn != "" {
                                    Text(restaurantModel.restaurants[restaurantModel.selectedRestaurant].foodItems[index].addOn)
                                        .font(.custom("AvenirNext-Medium", size: 13))
                                }
                                
                                Divider()
                            }
                        }
                        else if restaurantModel.selectedRestaurant == 0 && selectedSubMenu == 1 {
                            ForEach(0..<restaurantModel.restaurants[restaurantModel.selectedRestaurant].beverageItems.count, id: \.self) { index in
                                HStack (alignment: .top) {
                                    Text(restaurantModel.restaurants[restaurantModel.selectedRestaurant].beverageItems[index].name)
                                    Spacer()
                                    
                                    // MARK: Small, Medium, and Large buttons (if applicable)
                                    Group {
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].beverageItems[index].small! > 0 {
                                            Button {
                                                //
                                            } label: {
                                                Image(systemName: "s.circle.fill")
                                            }
                                        }
                                        
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].beverageItems[index].medium! > 0 {
                                            Button {
                                                //
                                            } label: {
                                                Image(systemName: "m.circle.fill")
                                            }
                                        }
                                        
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].beverageItems[index].large! > 0 {
                                            Button {
                                                //
                                            } label: {
                                                Image(systemName: "l.circle.fill")
                                            }
                                            .padding(.trailing)
                                        }
                                    }
                                    .padding(.horizontal, 5)
                                    
                                    if restaurantModel.restaurants[restaurantModel.selectedRestaurant].beverageItems[index].oneSize! > 0 {
                                        Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].beverageItems[index].oneSize!))")
                                            .font(.custom("AvenirNext-Bold", size: 18))
                                    }
                                    else {
                                        Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].beverageItems[index].small!))")
                                            .font(.custom("AvenirNext-Bold", size: 18))
                                    }
                                }
                                
                                Divider()
                            }
                        }
                    }
                    .font(.custom("AvenirNext-Medium", size: 18))
                    .lineLimit(1)
                    .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                }
                .padding()
            }
            .padding(.top)
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color("BackgroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])")
            .ignoresSafeArea())
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .colorScheme(.dark)
            .environmentObject(RestaurantModel())
        
        MenuView()
            .colorScheme(.light)
            .environmentObject(RestaurantModel())
    }
}
