//
//  ProfileView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    
    @State var firstName = ""
    @State var lastName = ""
    
    var body: some View {
        VStack {
            
            Text("Setup your profile")
                .font(Font.titleText)
                .padding(.top, 54)
            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            Button {
                //
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color.white)
                    Circle()
                        .stroke(Color("profile-image-border"), lineWidth: 2)
                    
                    Image(systemName: "camera.fill")
                        .tint(Color("icons-input"))
                }
                .frame(width: 134, height: 134)
            }
            
            Spacer()
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(ProfileTextFieldStyle())
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(ProfileTextFieldStyle())
            
            Spacer()
            
            Button {
                currentStep = .contacts
            } label: {
                Text("Continue")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            
        }
        .padding(.horizontal, 20)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(currentStep: .constant(.profile))
    }
}
