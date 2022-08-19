//
//  CartView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State var isChecked: Bool = false
    private var colorSchemeSuffix = ["(DD)", "(UJB)"]
    
    var body: some View {
        let donation = isChecked ? ceil(cartModel.total * 1.1075) - cartModel.total * 1.1075 : 0
        
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(cartModel.menuItems, id: \.id) { menuItem in
                    MenuItemRow(menuItem: menuItem)
                }
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    // MARK: - Subtotal
                    HStack {
                        Text("Subtotal (\(cartModel.menuItems.count) \(cartModel.menuItems.count == 1 ? "item" : "items"))")
                            .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                        Spacer()
                        Text("$\(String(format: "%.2f", cartModel.total))")
                            .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                            .font(.custom("AvenirNext-Bold", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    // MARK: - Tax (10.75%)
                    HStack {
                        Text("Taxes")
                            .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                        Spacer()
                        Text("$\(String(format: "%.2f", cartModel.total * 0.1075))")
                            .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                            .font(.custom("AvenirNext-Bold", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    // MARK: - ACCESS Donation
                    if isChecked {
                        HStack {
                            Text("ACCESS Donation")
                                .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                            
                            Button {
                                //
                            } label: {
                                Image(systemName: "info.circle.fill")
                            }
                            
                            Spacer()
                            Text("$\(String(format: "%.2f", donation))")
                                .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                                .font(.custom("AvenirNext-Bold", size: 16))
                        }
                        .padding(.bottom, 5)
                    }
                    
                    // MARK: - Total
                    HStack {
                        Text("Total")
                            .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                        Spacer()
                        Text("$\(String(format: "%.2f", cartModel.total * 1.1075 + donation))")
                            .foregroundColor(Color("ForegroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                            .font(.custom("AvenirNext-Bold", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    Text("\(Image(systemName: isChecked ? "checkmark.square.fill" : "square"))    I would like to round up your total by donating to ACCESS, a Black-owned non-profit in Chicago's South Side.")
                        .padding(.top)
                        .onTapGesture {
                            isChecked.toggle()
                        }
                }
                .padding(.horizontal)
                .font(.custom("AvenirNext-Medium", size: 16))
            }
            .padding(.vertical)
            
            Button {
                //
            } label: {
                ZStack {
                    Rectangle()
                        .frame(minWidth: 100, maxWidth: 400)
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(5)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    
                    Text("Continue Ordering")
                        .foregroundColor(Color("AccentColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                        .font(.custom("AvenirNext-Medium", size: 18))
                }
            }
            .buttonStyle(.plain)
            .padding(.top)
            
            Button {
                //
            } label: {
                ZStack {
                    Rectangle()
                        .frame(minWidth: 100, maxWidth: 400)
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(5)
                        .padding(.horizontal)
                        .foregroundColor(Color("AccentColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
                    
                    Text("Pay ")
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Medium", size: 18))
                    +
                    Text("$\(String(format: "%.2f", cartModel.total * 1.1075 + donation))")
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                }
            }
            .buttonStyle(.plain)
            .padding(.top)
            
            PaymentButton(action: {})
                .padding()
        }
        .safeAreaInset(edge: .top) {
            VStack {
                HStack {
                    Spacer()
                    Text("Your Order")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .textCase(.uppercase)
                        .foregroundColor(.white)
                    Spacer()
                }
                
            }
            .padding()
            .background(Color("AccentColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
        }
        .navigationBarHidden(true)
        .background(Color("BackgroundColor \(colorSchemeSuffix[restaurantModel.selectedRestaurant])"))
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}

extension View {
    func navigationBarTitle<Content>(
        @ViewBuilder content: () -> Content
    ) -> some View where Content : View {
        self.toolbar {
            ToolbarItem(placement: .principal, content: content)
        }
    }
}
