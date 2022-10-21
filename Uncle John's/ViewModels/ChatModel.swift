//
//  ChatModel.swift
//  Uncle John's
//
//  Created by Jamal Riley on 10/20/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatModel: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    let db = Firestore.firestore()
    
    init() {
        getMessages()
    }
    
    func getMessages() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into message: \(error)")
                    return nil
                }
            }
            
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    
    func sendMessage(text: String) {
        do {
            let newMsg = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            try db.collection("messages").document().setData(from: newMsg)
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
    }
}
