//
//  EmptyCartView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/23/22.
//

import SwiftUI

struct EmptyCartView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color("BackgroundColor (\(restaurantModel.selectedRestaurant == 0 ? "DD" : "UJB"))")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ZStack {
                    Image("Order Bag without Handle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    if restaurantModel.selectedRestaurant == 0 {
                        Image("Dat Donut Header")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(red: 88/255, green: 58/255, blue: 23/255, opacity: 0.4))
                            .frame(width: 90)
                            .padding(.top, 25)
                    } else {
                        ZStack {
                            Image("Uncle John's Header (Bottom)")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color(red: 88/255, green: 58/255, blue: 23/255, opacity: 0.25))
                                .frame(width: 125)
                                .padding(.top, 25)
                            
                            Image("Uncle John's Header (Top)")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color(red: 88/255, green: 58/255, blue: 23/255, opacity: 0.4))
                                .frame(width: 125)
                                .padding(.top, 25)
                        }
                    }
                    
                    Image("Order Bag Handle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                }
                
                Text("Your order is empty. 😞")
                    .font(.custom("AvenirNext-Medium", size: 24))
                
                Text("Feelin' hungry?")
                    .font(.custom("AvenirNext-Medium", size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        Capsule()
                            .frame(width: 160, height: 40)
                            .foregroundColor(Color("AccentColor (\(restaurantModel.selectedRestaurant == 0 ? "DD" : "UJB"))"))
                        
                        Text("Start Ordering")
                            .font(.custom("AvenirNext-Medium", size: 18))
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(.plain)

                Spacer()
            }
            .safeAreaInset(edge: .top) {
                VStack {
                    HStack {
                        Text("Your Order")
                            .font(.custom("AvenirNext-Bold", size: 30))
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
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"), Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])")]), startPoint: .top, endPoint: .bottom)
                )
            }
            .navigationBarHidden(true)
        }
    }
}

struct EmptyCartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartView()
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
