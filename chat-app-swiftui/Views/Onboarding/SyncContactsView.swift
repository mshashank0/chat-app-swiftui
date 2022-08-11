//
//  SyncContactsView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI

struct SyncContactsView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    @Binding var currentStep: OnboardingStep
    @Binding var isOnboarding: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("onboarding-all-set")
                
            Text("Awesome!")
                .font(Font.chatHeading)
                .padding(.top, 32)
            
            Text("Continue to Start chatting with your friends.")
                .font(Font.bodyParagraph)
                .padding(.top, 6)
            
            Spacer()
            
            Button {
                isOnboarding = false
            } label: {
                Text("Continue")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
           
        }
        .padding(.horizontal, 20)
        .onAppear {
            // Get local contacts
            contactsViewModel.getLocalContacts()
        }
    }
    
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactsView(currentStep: .constant(.contacts), isOnboarding: .constant(true))
    }
}
