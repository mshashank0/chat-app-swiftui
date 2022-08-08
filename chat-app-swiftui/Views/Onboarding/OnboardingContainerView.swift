//
//  OnboardingContainerView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI

enum OnboardingStep: Int {
    case welcome = 0
    case phoneNumber = 1
    case verification = 2
    case profile = 3
    case contacts = 4
}

struct OnboardingContainerView: View {
    
    @State var currentStep: OnboardingStep = .welcome
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            switch currentStep {
            case .welcome:
                WelcomeView(currentStep: $currentStep)
            case .phoneNumber:
                PhoneNumberView()
            case .verification:
                VerificationView()
            case .profile:
                ProfileView()
            case .contacts:
                ContactsView()
            }
        }
        
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView()
    }
}
