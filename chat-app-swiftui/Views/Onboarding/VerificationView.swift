//
//  VerificationView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI
import Combine

struct VerificationView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var currentStep: OnboardingStep
    @State var verificationCode = ""
    @Binding var isOnboarding: Bool
    @State var isButtonDisabled: Bool = false
    @State var isErrorLabelVisible: Bool = false
    
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
            
            // Error label
            Text("Invalid code")
                .foregroundColor(.red)
                .font(Font.smallText)
                .padding()
                .opacity(isErrorLabelVisible ? 1.0 : 0)
            
            Spacer()
            
            Button {
                
                isErrorLabelVisible = false
                isButtonDisabled = true
                
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    if error == nil {
                        // Check if this user has a profile
                        DatabaseService().checkUserProfile { exists in
                            
                            if exists {
                                // End the onboarding
                                isOnboarding = false
                                
                                // Load contacts
                                contactsViewModel.getLocalContacts()
                                
                                // Load chats
                                chatViewModel.getChats()
                            }
                            else {
                                // Move to the profile creation step
                                currentStep = .profile
                            }
                        }
                    }
                    else {
                        // show error
                        isErrorLabelVisible = true
                    }
                    
                    isButtonDisabled = false
                }
            } label: {
                HStack {
                    Text("Next")
                    
                    if isButtonDisabled {
                        ProgressView()
                            .padding(.leading, 2)
                    }
                }
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            .disabled(isButtonDisabled)

        }
        .padding(.horizontal, 20)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verification), isOnboarding: .constant(false), isButtonDisabled: false, isErrorLabelVisible: false)
    }
}
