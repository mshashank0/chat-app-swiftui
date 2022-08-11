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
    
    @Binding var isOnboaring: Bool
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            switch currentStep {
            case .welcome:
                WelcomeView(currentStep: $currentStep)
            case .phoneNumber:
                PhoneNumberView(currentStep: $currentStep, phoneNumber: "")
            case .verification:
                VerificationView(currentStep: $currentStep)
            case .profile:
                ProfileView(currentStep: $currentStep)
            case .contacts:
                SyncContactsView(currentStep: $currentStep, isOnboarding: $isOnboaring)
            }
        }
        
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView( isOnboaring: .constant(true))
    }
}
