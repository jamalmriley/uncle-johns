//
//  MessageBubble.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/20/22.
//

import SwiftUI

struct MessageBubble: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State private var showTime = false
    @State private var showActions = false
    var message: Message
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            if showActions {
                HStack {
                    Button {
                        //
                    } label: {
                        Image(systemName: "hand.thumbsup.fill")
                            .padding(5)
                            .background(Color("CustomGray"))
                            .cornerRadius(25)
                    }
                    
                    Button {
                        //
                    } label: {
                        Image(systemName: "heart.fill")
                            .padding(5)
                            .background(Color("CustomGray"))
                            .cornerRadius(25)
                    }
                    
                    if !message.received {
                        Button {
                            //
                        } label: {
                            Image(systemName: "pencil")
                                .padding(5)
                                .background(Color("CustomGray"))
                                .cornerRadius(25)
                        }
                    }
                    
                    Button {
                        //
                    } label: {
                        Image(systemName: "rectangle.portrait.on.rectangle.portrait")
                            .padding(5)
                            .background(Color("CustomGray"))
                            .cornerRadius(25)
                    }
                }
                .padding(5)
                .background(Color("CustomGray"))
                .cornerRadius(25)
                .buttonStyle(.plain)
            }
            
            HStack {
                Text(message.text)
                    .font(.custom("AvenirNext-Medium", size: 16))
                    .padding()
                    .background(message.received ? Color("CustomGray") : Color("TertiaryColor (\(restaurantModel.selectedRestaurant == 0 ? "DD" : "UJB"))"))
                    .cornerRadius(cornerRadius, corners: corners)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                withAnimation {
                    showTime.toggle()
                }
            }
            .onLongPressGesture {
                withAnimation {
                    showActions.toggle()
                }
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.custom("AvenirNext-Medium", size: 12))
                    .foregroundColor(.gray)
                    .padding(message.received ? .leading : .trailing)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "12345", text: "Hello, World!", received: false, timestamp: Date()), cornerRadius: 30, corners: [.topLeft, .bottomLeft, .bottomRight])
            .environmentObject(RestaurantModel())
    }
}
