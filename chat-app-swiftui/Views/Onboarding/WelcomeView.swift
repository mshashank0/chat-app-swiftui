//
//  WelcomeView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var currentStep: OnboardingStep
    
    var body: some View {
            VStack {
                Spacer()
                
                Image("onboarding-welcome")
                    
                Text("Welcome to Chat App")
                    .font(Font.chatHeading)
                    .padding(.top, 32)
                
                Text("Simple and fuss-free chat experience")
                    .font(Font.bodyParagraph)
                    .padding(.top, 6)
                
                Spacer()
                
                Button {
                    currentStep = .phoneNumber
                } label: {
                    Text("Continue")
                }
                .buttonStyle(OnboardingButtonStyle())
                
                Text("By tapping ‘Continue’, you agree to our Privacy Policy.")
                    .font(Font.caption)
                    .padding(.top, 16)
                    .padding(.bottom, 60)


            }
            .padding(.horizontal, 20)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(currentStep: .constant(.welcome))
    }
}
