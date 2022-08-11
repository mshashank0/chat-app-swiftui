//
//  chat_app_swiftuiApp.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 05/08/22.
//

import SwiftUI

@main
struct chat_app_swiftuiApp: App {
    
    //register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ContactsViewModel())
        }
    }
}
