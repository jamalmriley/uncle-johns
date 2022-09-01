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
    @Environment(\.presentationMode) var presentationMode
    @State var isChecked: Bool = false
    
    var body: some View {
        let donation = isChecked ? ceil(cartModel.total * 1.1075) - cartModel.total * 1.1075 : 0
        
        VStack {
            ScrollView(showsIndicators: false) {
                
                HStack {
                    Text("Your Meal")
                        .font(.custom("AvenirNext-Bold", size: 20))
                        .textCase(.uppercase)
                        .padding(.vertical, 5)
                    
                    Spacer()
                }
                
                ForEach(cartModel.menuItems, id: \.id) { menuItem in
                    MenuItemRow(menuItem: menuItem)
                }
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    // MARK: - Subtotal
                    HStack {
                        Text("Subtotal (\(cartModel.menuItems.count) \(cartModel.menuItems.count == 1 ? "item" : "items"))")
                            .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                        Spacer()
                        Text("$\(String(format: "%.2f", cartModel.total))")
                            .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            .font(.custom("AvenirNext-Bold", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    // MARK: - Tax (10.75%)
                    HStack {
                        Text("Taxes")
                            .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                        Spacer()
                        Text("$\(String(format: "%.2f", cartModel.total * 0.1075))")
                            .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            .font(.custom("AvenirNext-Bold", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    // MARK: - ACCESS Donation
                    if isChecked {
                        HStack {
                            Text("ACCESS Donation")
                            
                            Button {
                                //
                            } label: {
                                Image(systemName: "info.circle")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            }
                            
                            Spacer()
                            Text("$\(String(format: "%.2f", donation))")
                                .font(.custom("AvenirNext-Bold", size: 16))
                        }
                        .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                        .padding(.bottom, 5)
                    }
                    
                    // MARK: - Total
                    HStack {
                        Text("Total")
                            .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                        Spacer()
                        Text("$\(String(format: "%.2f", cartModel.total * 1.1075 + donation))")
                            .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            .font(.custom("AvenirNext-Bold", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    // MARK: - Round Up & Donate
                    VStack(alignment: .leading) {
                        
                        // MARK: Round Up and Donate
                        HStack {
                            Text("Round Up & Donate")
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .textCase(.uppercase)
                            Button {
                                //
                            } label: {
                                Image(systemName: "info.circle")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            }
                        }
                        
                        HStack {
                            Image("southside0")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 125, height: 125)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.trailing)
                            
                            VStack(alignment: .leading) {
                                Text("ACCESS Initiative")
                                    .font(.custom("AvenirNext-Bold", size: 22))
                                    .textCase(.uppercase)
                                Text("A Black-owned non-profit in Chicago's South Side fighting for better access to food for all of its citizens.")
                            }
                            
                            
                        }
                        
                        Text("\(Image(systemName: isChecked ? "checkmark.square.fill" : "square"))    Yes, I want to round up & donate!")
                            .padding(.top)
                            .onTapGesture {
                                isChecked.toggle()
                            }
                        Text("100% of your donation will go toward the ACCESS Initative, and we'll match your donation too!")
                            .foregroundColor(.gray)
                            .font(.custom("AvenirNext-Medium", size: 14))
                            .padding(.top, 1)
                    }
                    .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                    .font(.custom("AvenirNext-Medium", size: 16))
                    
                    // MARK: - Bottom Buttons
                    /* Group {
                        // MARK: "Continue Ordering" Button
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(minWidth: 100, maxWidth: 400)
                                    .frame(height: 45)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(5)
                                    .foregroundColor(.white)
                                
                                Text("Continue Ordering")
                                    .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                    .font(.custom("AvenirNext-Medium", size: 18))
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.top)
                        
                        // MARK: "Pay" Button
                        Button {
                            //
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(minWidth: 100, maxWidth: 400)
                                    .frame(height: 45)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(5)
                                    .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                
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
                        
                        // MARK: "Apple Pay" Button
                        PaymentButton(action: {})
                            .padding(.vertical)
                    } */
                }
                .font(.custom("AvenirNext-Medium", size: 16))
            }
            
            // MARK: "Apple Pay" Button
            PaymentButton(action: {})
        }
        .padding(.horizontal)
        .safeAreaInset(edge: .top) {
            VStack {
                HStack {
                    Text("Your Order")
                        .font(.custom("AvenirNext-Bold", size: 30))
                        //.textCase(.uppercase)
                        .foregroundColor(.white)
                    Spacer()
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .renderingMode(.template)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
        }
        .navigationBarHidden(true)
        .background(Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
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
