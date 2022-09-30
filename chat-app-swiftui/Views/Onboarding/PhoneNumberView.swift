//
//  PhoneNumberView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var phoneNumber: String
    
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
                    TextField("e.g. +1 613 515 0123", text: $phoneNumber)
                        .font(Font.bodyParagraph)
                        .keyboardType(.phonePad)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber, pattern: "+## (###) ###-####", replacementCharacter: "#")
                        }
                    
                    Spacer()
                    
                    Button {
                        phoneNumber = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                }
                .padding()
            }
            
            // Error label
            Text("Please enter valid phone number")
                .foregroundColor(.red)
                .font(Font.smallText)
                .padding()
                .opacity(isErrorLabelVisible ? 1.0 : 0)
            
            
            Spacer()
            
            Button {
                
                isErrorLabelVisible = false
                isButtonDisabled = true
                
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    if error == nil {
                        currentStep = .verification
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

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phoneNumber), phoneNumber: "", isButtonDisabled: false, isErrorLabelVisible: false)
    }
}
