//
//  CustomTabBar.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI

enum Tabs: Int {
    case chats = 0
    case contacts = 1
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    @Binding var isChatShowing: Bool
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            
            Button {
                //chat
                selectedTab = .chats
            } label: {
                TabBarButton(imageName: "bubble.left", buttonText: "Chats", isActive: selectedTab == .chats)
            }
            
            Button {
                // Clear the selected chat
                chatViewModel.clearSelectedChat()
                
                // Show conversation view for new message
                isChatShowing = true
            } label: {
                VStack(alignment: .center, spacing: 4) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Text("New Chat")
                        .font(Font.tabBar)
                }
                .tint(Color("icons-primary"))
            }
            
            Button {
                //contact
                selectedTab = .contacts
            } label: {
                TabBarButton(imageName: "person", buttonText: "Contacts", isActive: selectedTab == .contacts)
            }
        }
        .tint(Color("icons-secondary"))
        .frame(height: 82)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.contacts), isChatShowing: .constant(false))
    }
}
