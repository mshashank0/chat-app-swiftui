//
//  ProfileTextFieldStyle.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 09/08/22.
//

import Foundation
import SwiftUI

struct ProfileTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            Rectangle()
                .cornerRadius(8)
                .frame(height: 43)
                .foregroundColor(Color("input"))
            
            //Refering text field
            configuration
                .font(Font.tabBar)
                .padding()
        }
    }
}
