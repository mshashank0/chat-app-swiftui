//
//  RootView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 05/08/22.
//

import SwiftUI

struct RootView: View {
    
    // For detecting when the app state changes
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    @State var isChatShowing = false
    
    @State var isSettingsShowing = false
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                
                switch selectedTab {
                    
                case .chats:
                    ChatsListView(isChatShowing: $isChatShowing,
                                  isSettingsShowing: $isSettingsShowing)
                case .contacts:
                    ContactsListView(isChatShowing: $isChatShowing,
                                     isSettingsShowing: $isSettingsShowing)
                }
                
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab, isChatShowing: $isChatShowing)
            }
        }
        .onAppear(perform: {
            if !isOnboarding {
                contactsViewModel.getLocalContacts()
            }
        })
        .fullScreenCover(isPresented: $isOnboarding) {
            // On onboarding dismiss
        } content: {
            OnboardingContainerView(isOnboaring: $isOnboarding)
        }
        .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
            ConversationView(isChatShowing: $isChatShowing)
        }
        .fullScreenCover(isPresented: $isSettingsShowing, onDismiss: nil, content: {
            
            // The Settings View
            SettingsView(isSettingsShowing: $isSettingsShowing,
                         isOnboarding: $isOnboarding)
        })
        .onChange(of: scenePhase) { newPhase in
            
            if newPhase == .active {
                print("Active")
            } else if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .background {
                print("Background")
                chatViewModel.chatListViewCleanup()
            }
        }
        
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
