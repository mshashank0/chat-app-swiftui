//
//  VerificationView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var verificationCode = ""
    @Binding var isOnboarding: Bool
    
    var body: some View {
        VStack {
                        
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 54)
            
            Text("Enter your mobile number below. We’ll send you a verification code after.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
                .padding(.bottom, 36)
            
            ZStack {
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("xxxxxx", text: $verificationCode)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationCode)) { _ in
                            TextHelper.limitText(&verificationCode, 6)
                        }
                    
                    Spacer()
                    
                    Button {
                        verificationCode = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                }
                .padding()
            }
            
            Spacer()
            
            Button {
                
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    if error == nil {
                        // Check if this user has a profile
                        DatabaseService().checkUserProfile { exists in
                            
                            if exists {
                                // End the onboarding
                                isOnboarding = false
                            }
                            else {
                                // Move to the profile creation step
                                currentStep = .profile
                            }
                        }
                    }
                    else {
                        // show error
                    }
                }
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)

        }
        .padding(.horizontal, 20)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verification), isOnboarding: .constant(false))
    }
}
