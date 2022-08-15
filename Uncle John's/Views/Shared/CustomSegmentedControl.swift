//
//  CustomSegmentedControl.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/14/22.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var selection: Int
    var options: [String]
    let width: CGFloat
    let color = Color("TertiaryColor")
    let fontSize: CGFloat
    
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
                            }
                        }
                }
                .overlay(
                    Text(options[index])
                        .font(isSelected ? .custom("AvenirNext-Bold", size: fontSize) : .custom("AvenirNext-Medium", size: fontSize))
                        .textCase(.uppercase)
                        .foregroundColor(isSelected ? Color("ForegroundColor (Generic)") : .gray)
                )
            }
        }
        .frame(width: width, height: 40)
        .cornerRadius(20)
    }
}
