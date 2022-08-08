//
//  OnboardingButtonStyle.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import Foundation
import SwiftUI

struct OnboardingButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(height: 50)
                .cornerRadius(4)
                .foregroundColor(Color("button-primary"))
            configuration.label
                .font(Font.button)
                .foregroundColor(Color("text-button"))
        }
    }
}
