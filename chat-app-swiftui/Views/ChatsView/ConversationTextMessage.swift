//
//  ConversationTextMessage.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 29/08/22.
//

import SwiftUI

struct ConversationTextMessage: View {
    
    var msg: String
    var isFromUser: Bool
    var name: String?
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 4) {
            // Name
            if let name = name {
                Text(name)
                    .font(Font.chatName)
                    .foregroundColor(Color("bubble-primary"))
            }
            
            // Text
            Text(msg)
                .font(Font.bodyParagraph)
                .foregroundColor(isFromUser ? Color("text-button") : Color("text-primary"))
            
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
        .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
    }
}

struct ConversationTextMessage_Previews: PreviewProvider {
    static var previews: some View {
        ConversationTextMessage(msg: "Test", isFromUser: true)
    }
}
