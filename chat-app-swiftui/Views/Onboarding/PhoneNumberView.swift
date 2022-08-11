//
//  PhoneNumberView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var phoneNumber: String
    
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
            
            Spacer()
            
            Button {
                currentStep = .verification
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)

        }
        .padding(.horizontal, 20)
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phoneNumber), phoneNumber: "")
    }
}
