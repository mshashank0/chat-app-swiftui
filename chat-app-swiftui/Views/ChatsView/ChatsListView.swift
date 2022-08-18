//
//  ChatsListView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 11/08/22.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    var body: some View {
        if chatViewModel.chats.count > 0 {
            List(chatViewModel.chats) { chat in
                Text(chat.id ?? "Empty")
            }
        }
        else {
           Text("no chat")
        }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView()
    }
}
