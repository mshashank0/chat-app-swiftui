//
//  GroupProfilePicView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 12/09/22.
//

import SwiftUI

struct GroupProfilePicView: View {
    
    var users: [User]
    
    var body: some View {
        
        let offset = Int(30 / users.count) * -1
        
        ZStack {
            
            ForEach (Array(users.enumerated()), id:\.element) { index, user in
                
                ProfilePicView(user: user)
                    .offset(x: CGFloat(offset * index))
                
            }
            
        }
        // TODO: offset by half the total offset in the other direction
        
    }
}
