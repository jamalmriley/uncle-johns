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
            Header()
            
            VStack {
                // MARK: Header and Restaurant Picker
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
                                ForEach(0..<restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0.count, id: \.self) { index in
                                    HStack (alignment: .top) {
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].quantity > 0 {
                                            Text("(\(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].quantity))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                        Text(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].name)
                                        Spacer()
                                        Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].singleSizePrice))")
                                            .font(.custom("AvenirNext-Bold", size: 16))
                                    }
                                    
                                    if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].description != "" {
                                        Text(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].description)
                                            .font(.custom("AvenirNext-Medium", size: 13))
                                    }
                                    
                                    Divider()
                                }
                            }
                            else if restaurantModel.selectedRestaurant == 0 && selectedSubMenu == 1 {
                                ForEach(0..<restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1.count, id: \.self) { index in
                                    HStack (alignment: .top) {
                                        Text(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].name)
                                        Spacer()
                                        
                                        // MARK: Small, Medium, and Large buttons (if applicable)
                                        Group {
                                            if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].price1 > 0 {
                                                Button {
                                                    //
                                                } label: {
                                                    Image(systemName: "s.circle.fill")
                                                }
                                            }
                                            
                                            if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].price2 > 0 {
                                                Button {
                                                    //
                                                } label: {
                                                    Image(systemName: "m.circle.fill")
                                                }
                                            }
                                            
                                            if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].price3 > 0 {
                                                Button {
                                                    //
                                                } label: {
                                                    Image(systemName: "l.circle.fill")
                                                }
                                                .padding(.trailing)
                                            }
                                        }
                                        .padding(.horizontal, 5)
                                        
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].singleSizePrice > 0 {
                                            Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].singleSizePrice))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                        else {
                                            Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].price1))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                    }
                                    
                                    Divider()
                                }
                            }
                            else if restaurantModel.selectedRestaurant == 1 && selectedSubMenu == 0 {
                                ForEach(0..<restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0.count, id: \.self) { index in
                                    HStack (alignment: .top) {
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].quantity > 0 {
                                            Text("(\(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].quantity))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                        Text(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].name)
                                        Spacer()
                                        
                                        // MARK: Small, Medium, and Large buttons (if applicable)
                                        Group {
                                            if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].price1 > 0 {
                                                Button {
                                                    //
                                                } label: {
                                                    Image(systemName: "s.circle.fill")
                                                }
                                            }
                                            
                                            if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].price2 > 0 {
                                                Button {
                                                    //
                                                } label: {
                                                    Image(systemName: "m.circle.fill")
                                                }
                                            }
                                            
                                            if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].price3 > 0 {
                                                Button {
                                                    //
                                                } label: {
                                                    Image(systemName: "l.circle.fill")
                                                }
                                                .padding(.trailing)
                                            }
                                        }
                                        .padding(.horizontal, 5)
                                        
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].singleSizePrice > 0 {
                                            Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].singleSizePrice))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                        else {
                                            Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[index].price1))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                    }
                                    
                                    Divider()
                                }
                            }
                            else if restaurantModel.selectedRestaurant == 1 && selectedSubMenu == 1 {
                                ForEach(0..<restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1.count, id: \.self) { index in
                                    HStack (alignment: .top) {
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].quantity > 0 {
                                            Text("(\(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].quantity))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                        Text(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].name)
                                        Spacer()
                                        
                                        // MARK: Small, Medium, and Large buttons (if applicable)
                                        Group {
                                            if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].price1 > 0 {
                                                Button {
                                                    //
                                                } label: {
                                                    Image(systemName: "circle.lefthalf.filled")
                                                }
                                            }
                                            
                                            if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].price2 > 0 {
                                                Button {
                                                    //
                                                } label: {
                                                    Image(systemName: "circle.fill")
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 5)
                                        
                                        if restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].singleSizePrice > 0 {
                                            Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].singleSizePrice))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                        else {
                                            Text("$\(String(format: "%.2f", restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[index].price1))")
                                                .font(.custom("AvenirNext-Bold", size: 16))
                                        }
                                    }
                                    
                                    Divider()
                                }
                            }
                        }
                        .font(.custom("AvenirNext-Medium", size: 16))
                        .lineLimit(1)
                        .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                    }
                    .padding()
                }
                .padding(.top)
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .background(Color("BackgroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
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
