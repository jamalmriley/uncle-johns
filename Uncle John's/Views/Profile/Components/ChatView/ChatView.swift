//
//  ChatView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/20/22.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @StateObject var chatModel = ChatModel()
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    ForEach(chatModel.messages, id: \.id) { message in
                        MessageBubble(message: message)
                    }
                    .padding(.top, 20)
                }
                .padding(.top, 5)
                .background(Color("BackgroundColor"))
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .onChange(of: chatModel.lastMessageId) { id in
                    withAnimation {
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
            }
            .background(Color("TertiaryColor (\(restaurantModel.selectedRestaurant == 0 ? "DD" : "UJB"))"))
            
            MessageField()
                .environmentObject(ChatModel())
        }
        .safeAreaInset(edge: .top) {
            ChatTitleRow()
        }
        .navigationBarHidden(true)
        .background(Color("BackgroundColor"))
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
