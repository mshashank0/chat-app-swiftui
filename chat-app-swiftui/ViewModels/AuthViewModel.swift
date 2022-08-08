//
//  AuthViewModel.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 08/08/22.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
   
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func getUserId() -> String{
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logout() {
        try? Auth.auth().signOut()
    }
}
