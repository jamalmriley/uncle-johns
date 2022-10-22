//
//  PaymentCard.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/21/22.
//

import SwiftUI

struct PaymentCard: View {
    var name: String
    var width: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .aspectRatio(1.58577250834, contentMode: .fit) /// The dimensions of a standard debit/credit card is 85.60 mm × 53.98 mm, thus making the aspect ratio 1.58577250834.
                    .frame(width: width)
                    .foregroundColor(Color(red: 26/255, green: 66/255, blue: 148/255))
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 10, x: 0, y: 5)
                
                Image(name)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(height: 30)
                    .padding([.top, .trailing], 20)
            }
            
            HStack {
                Text(".... 1234")
                Spacer()
                Text("01/23")
            }
            .font(.custom("AvenirNext-Medium", size: 18))
            .foregroundColor(.white)
            .padding([.horizontal, .bottom], 20)
        }
        .aspectRatio(1.58577250834, contentMode: .fit) /// The dimensions of a standard debit/credit card is 85.60 mm × 53.98 mm, thus making the aspect ratio 1.58577250834.
        .frame(width: width)
        .contextMenu {
            Button {
                print("Editing card info...")
            } label: {
                Label("Edit Info", systemImage: "pencil")
            }
            
            Button {
                print("Removing card info...")
            } label: {
                Label("Remove", systemImage: "trash")
            }
        }
    }
}

struct PaymentCard_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCard(name: "Chase", width: 350)
    }
}
