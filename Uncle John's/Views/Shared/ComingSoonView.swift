//
//  ComingSoonView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/10/22.
//

import SwiftUI

struct ComingSoonView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])")
                .ignoresSafeArea()
            VStack {
                Image("Dog 5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                
                Text("Coming Soon!")
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .textCase(.uppercase)
            }
        }
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView()
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
