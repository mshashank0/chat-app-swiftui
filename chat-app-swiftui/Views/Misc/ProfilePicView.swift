//
//  ProfilePicView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 18/08/22.
//

import SwiftUI

struct ProfilePicView: View {
   
    var user: User
    
    var body: some View {
        
        ZStack {
           
            // Check if user has a photo set
            if user.photo == nil {
                
                // Display circle with first letter of first name
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Text(user.firstname?.prefix(1) ?? "")
                        .bold()
                }
                
            }
            else {
                // Create URL from user photo url
                let photoUrl = URL(string: user.photo ?? "")
                
                //Profile image
                AsyncImage(url: photoUrl) { phase in
                    switch phase {
                    case .empty:
                        // Currently fetching
                        ProgressView()
                    case .failure:
                        // Display circle with first letter of first name
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            Text(user.firstname?.prefix(1) ?? "")
                                .bold()
                        }
                    case .success(let image):
                        //Display image
                        image
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .clipped()
                    @unknown default:
                        fatalError()
                    }
                }
            }
            
            // Blue border
            Circle()
                .stroke(Color("create-profile-border"), lineWidth: 2)
        }
        .frame(width: 44, height: 44)
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(user: User())
    }
}
