//
//  RewardsView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct RewardsView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var cartModel: CartModel
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])")
                    .ignoresSafeArea()
                
                VStack {
                    Header()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            
                            // MARK: - My Points
                            Group {
                                Text("My Points")
                                    .font(.custom("AvenirNext-Bold", size: 24))
                                    .textCase(.uppercase)
                                    .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                
                                HStack {
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("773")
                                            .font(.custom("AvenirNext-Bold", size: 64))
                                        
                                        Text("points")
                                            .font(.custom("AvenirNext-Bold", size: 32))
                                            .textCase(.uppercase)
                                        
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
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 5) {
                                        Text("Next reward in 227 points.")
                                        Button {
                                            //
                                        } label: {
                                            Text("View points history")
                                        }
                                        
                                    }
                                    .font(.custom("AvenirNext-Medium", size: 16))
                                    .padding(.top, 5)
                                }
                            }
                            Divider()
                                .padding(.bottom)
                            
                            // MARK: - Rewards
                            Group {
                                Text("Rewards")
                                    .font(.custom("AvenirNext-Bold", size: 24))
                                    .textCase(.uppercase)
                                    .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(0..<10) { index in
                                            VStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 100, height: 100)
                                                    .foregroundColor(.black)
                                                
                                                Text("Reward \(index + 1)")
                                                    .font(.custom("AvenirNext-Medium", size: 16))
                                                    .frame(width: 100)
                                                    .multilineTextAlignment(.center)
                                                
                                                Button {
                                                    //
                                                } label: {
                                                    ZStack {
                                                        Capsule()
                                                            .frame(width: 70, height: 25)
                                                            .foregroundColor(Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
                                                        
                                                        Text("Scan")
                                                            .font(.custom("AvenirNext-Bold", size: 14))
                                                            .textCase(.uppercase)
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                                .buttonStyle(.plain)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                            Divider()
                                .padding(.top)
                            
                            // MARK: - Deals
                            Group {
                                Text("Deals")
                                    .font(.custom("AvenirNext-Bold", size: 24))
                                    .textCase(.uppercase)
                                    .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(0..<10) { index in
                                            VStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 100, height: 100)
                                                    .foregroundColor(.black)
                                                
                                                Text("Deal \(index + 1)")
                                                    .font(.custom("AvenirNext-Medium", size: 16))
                                                    .frame(width: 100)
                                                    .multilineTextAlignment(.center)
                                                
                                                Button {
                                                    //
                                                } label: {
                                                    ZStack {
                                                        Capsule()
                                                            .frame(width: 60, height: 25)
                                                            .foregroundColor(.white)
                                                        
                                                        Text("Get")
                                                            .font(.custom("AvenirNext-Bold", size: 14))
                                                            .textCase(.uppercase)
                                                            .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                                    }
                                                }
                                                .buttonStyle(.plain)
                                                
                                            }
                                        }
                                    }
                                }
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

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
