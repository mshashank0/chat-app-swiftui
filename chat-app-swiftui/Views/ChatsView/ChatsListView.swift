//
//  ChatsListView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 11/08/22.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        if chatViewModel.chats.count > 0 {
            List(chatViewModel.chats) { chat in
               
                Button {
                    
                    // Set selcted chat for the chatviewmodel
                    chatViewModel.selectedChat = chat
                    
                    // display conversation view
                    isChatShowing = true
                    
                } label: {
                    Text(chat.id ?? "empty chat id")
                }
                
            }
        }
        else {
           Text("no chat")
        }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: .constant(false))
    }
}
