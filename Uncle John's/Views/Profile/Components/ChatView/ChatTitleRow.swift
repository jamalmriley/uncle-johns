//
//  ChatTitleRow.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/19/22.
//

import SwiftUI

struct ChatTitleRow: View {
    var imageURL = URL(string: "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80")
    var name = "Rebecca B."
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(name)
                    .font(.custom("AvenirNext-Bold", size: 24))
                
                HStack {
                    Circle()
                        .frame(width: 7, height: 7)
                        .foregroundColor(.green)
                    
                    Text("Online")
                        .font(.custom("AvenirNext-Medium", size: 14))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "phone.fill")
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
                .cornerRadius(20)
        }
        .padding()
    }
}

struct ChatTitleRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatTitleRow()
            .environmentObject(RestaurantModel())
            .background(Color("TertiaryColor (\(RestaurantModel().selectedRestaurant == 0 ? "DD" : "UJB"))"))
    }
}
