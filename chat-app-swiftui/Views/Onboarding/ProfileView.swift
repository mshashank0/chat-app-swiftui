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
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isSourceMenuShowing = false
    
    @State var isSaveButtonDisabled = false
    
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
                isSourceMenuShowing = true
            } label: {
                ZStack {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    }
                    else {
                        Circle()
                            .foregroundColor(Color.white)
                        Image(systemName: "camera.fill")
                            .tint(Color("icons-input"))
                    }
                    Circle()
                        .stroke(Color("profile-image-border"), lineWidth: 2)
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
                isSaveButtonDisabled = true
                DatabaseService().setUserProfileData(firstname: firstName,
                                                     lastName: lastName,
                                                     photo: selectedImage) { success in
                    if success {
                        currentStep = .contacts
                        
                    }
                    else {
                        
                    }
                    isSaveButtonDisabled = false
                }
            } label: {
                Text(isSaveButtonDisabled ? "Uploading":"Save")
            }
            .buttonStyle(OnboardingButtonStyle())
            .disabled(isSaveButtonDisabled)
            .padding(.bottom, 87)
            
        }
        .confirmationDialog("Choose from", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                source = .photoLibrary
                isPickerShowing = true
            } label: {
                Text("Photo Library")
            }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button {
                    source = .camera
                    isPickerShowing = true
                } label: {
                    Text("Camera")
                }
            }
            
        })
        .padding(.horizontal, 20)
        .sheet(isPresented: $isPickerShowing) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: source)
        }
        
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(currentStep: .constant(.profile))
    }
}
