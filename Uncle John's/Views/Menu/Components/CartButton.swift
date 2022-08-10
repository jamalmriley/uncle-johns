//
//  CartButton.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI

struct CartButton: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var numOfMenuItems: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "bag")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(Color("ForegroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
                .padding(.top, 5)
            
            if numOfMenuItems > 0 {
                Text("\(numOfMenuItems)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(.red)
                    .cornerRadius(50)
            }
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(numOfMenuItems: 1)
            .environmentObject(RestaurantModel())
    }
}

