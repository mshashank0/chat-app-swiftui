//
//  ContactRow.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 11/08/22.
//

import SwiftUI

struct ContactRow: View {
    
    var user: User
    
    var body: some View {
        
        HStack (spacing: 24) {
            
            // Profile Image
            ProfilePicView(user: user)
            
            VStack (alignment: .leading, spacing: 4) {
                // Name
                Text("\(user.firstname ?? "") \(user.lastname ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
                // Phone number
                Text(user.phone ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            
            // Extra space
            Spacer()
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(user: User())
    }
}
