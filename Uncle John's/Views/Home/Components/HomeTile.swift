//
//  HomeTile.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI

struct HomeTile: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var image: String = "Chicago"
    var header: String = "Up the ACCESS."
    var description: String = "Learn more about the Chicago ACCESS Initative and what it's doing for Chicago's South Side."
    var buttonLabel: String = "Learn more"
    
    var body: some View {
        ZStack (alignment: .bottom) {
            ZStack {
                Rectangle()
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350)
                
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.4)
            }
            .frame(height: 350)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .background(.thinMaterial)
                    .frame(height: 140)
                
                VStack (alignment: .leading) {
                    // Learn more about the Chicago ACCESS Initative, an initiative dedicated to provide more and better eating and food awareness to Chicago's south side.
                    // Achieving Comfortable and Consummate Eating for the South Side
                    Text(header)
                        .font(.custom("AvenirNext-Bold", size: 20))
                    Text(description)
                        .font(.custom("AvenirNext-Medium", size: 14))
                    
                    Button {
                        //
                    } label: {
                        ZStack {
                            Capsule()
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color("AccentColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
                            Text(buttonLabel)
                                .font(.custom("AvenirNext-Medium", size: 16))
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal, 10)
            }
        }
        .frame(width: 350)
        .cornerRadius(10)
        .padding(.bottom)
    }
}
