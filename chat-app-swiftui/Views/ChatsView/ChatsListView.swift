//
//  ChatsListView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 11/08/22.
//

import SwiftUI

struct ChatsListView: View {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var isChatShowing: Bool
    @Binding var isSettingsShowing: Bool
    
    var body: some View {
        
        VStack {
            
            // Heading
            HStack {
                Text("Chats")
                    .font(Font.pageTitle)
                
                Spacer()
                
                Button {
                    // Shows settings
                    isSettingsShowing = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
                
                
            }
            .padding(.top, 20)
            .padding(.horizontal)
            
            // Chat list
            if chatViewModel.chats.count > 0 {
                
                List(chatViewModel.chats) { chat in
                    
                    Button {
                        
                        // Set selcted chat for the chatviewmodel
                        chatViewModel.selectedChat = chat
                        
                        // display conversation view
                        isChatShowing = true
                        
                    } label: {
                        
                        ChatsListRow(chat: chat,
                                     otherParticipants: contactsViewModel.getParticipants(ids: chat.participantsids))
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                }
                .listStyle(.plain)
                
            }
            else {
                
                Spacer()
                
                Image("no-chats-yet")
                
                Text("Hmm... no chats here yet!")
                    .font(Font.titleText)
                    .padding(.top, 32)
                
                Text("Chat a friend to get started")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                
                
                Spacer()
            }
        }
    }
}

struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView(isChatShowing: .constant(false),
                      isSettingsShowing: .constant(false))
    }
}
