//
//  MessageField.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/20/22.
//

import SwiftUI

struct MessageField: View {
    @EnvironmentObject var chatModel: ChatModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State private var message = ""
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Type your message here..."), text: $message)
                .font(.custom("AvenirNext-Medium", size: 16))
            
            Button {
                chatModel.sendMessage(text: message)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(message == "" ? .gray : Color("TertiaryColor (\(restaurantModel.selectedRestaurant == 0 ? "DD" : "UJB"))"))
                    .cornerRadius(50)
            }
            .disabled(message == "")
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("CustomGray"))
        .cornerRadius(50)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
            .environmentObject(ChatModel())
            .environmentObject(RestaurantModel())
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder.opacity(0.3)
                    .font(.custom("AvenirNext-Medium", size: 16))
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
