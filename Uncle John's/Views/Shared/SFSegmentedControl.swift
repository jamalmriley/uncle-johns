//
//  SFSegmentedControl.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/4/22.
//

import SwiftUI

struct SFSegmentedControl: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @Binding var selection: Int
    var options: [String]
    let width: CGFloat
    let color = Color("TertiaryColor")
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                let isSelected = selection == index
                ZStack {
                    Rectangle()
                        .fill(color.opacity(0.4))
                    
                    Rectangle()
                        .fill(color)
                        .cornerRadius(20)
                        .padding(2)
                        .opacity(selection == index ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.2,
                                                             dampingFraction: 2,
                                                             blendDuration: 0.5)) {
                                selection = index
                                restaurantModel.showMenuItemCustomization = false
                            }
                        }
                }
                .overlay(
                    Image(systemName: options[index])
                        .renderingMode(.template)
                        .foregroundColor(isSelected ? Color("ForegroundColor") : .gray)
                )
            }
        }
        .frame(width: width, height: 40)
        .cornerRadius(20)
    }
}
