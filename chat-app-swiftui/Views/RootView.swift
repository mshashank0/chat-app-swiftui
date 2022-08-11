//
//  RootView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 05/08/22.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .fullScreenCover(isPresented: $isOnboarding) {
            // On onboarding dismiss
        } content: {
            OnboardingContainerView( isOnboaring: $isOnboarding)
        }


    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
