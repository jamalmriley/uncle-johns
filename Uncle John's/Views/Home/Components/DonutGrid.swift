//
//  DonutGrid.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/18/22.
//

import SwiftUI

struct DonutGrid: View {
    let gridWidth: Int = 10
    let gridHeight: Int = 20
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        ZStack {
            Color("AccentColor (DD)")
                .frame(width: width, height: height)
            VStack {
                ForEach(0..<gridHeight, id: \.self) { index in
                    HStack {
                        ForEach(0..<gridWidth, id: \.self) { index in
                            Image("Dat Donut Icon")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .opacity(0.1)
                                .frame(width: 50, height: 40)
                        }
                    }
                }
            }
            .frame(width: width, height: height)
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct DonutGrid_Previews: PreviewProvider {
    static var previews: some View {
        DonutGrid(width: 100, height: 100, cornerRadius: 10)
    }
}
