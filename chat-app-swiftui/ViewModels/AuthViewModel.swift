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
    
    static func getLoggedInUserPhone() -> String {
        return Auth.auth().currentUser?.phoneNumber ?? ""
    }
    
    static func logout() {
        try? Auth.auth().signOut()
    }
    
    static func sendPhoneNumber(phone: String, completion: @escaping (Error?) -> Void) {
        // send phoen number to Firebase for auth
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone,
                                                       uiDelegate: nil)
        { verificationId, error in
            if error == nil {
                // got verification id
                UserDefaults.standard.set(verificationId, forKey: "authVerificationID")
            }
            DispatchQueue.main.async {
                // Notify the UI
                completion(error)
            }
        }
    }
    
    static func verifyCode(code: String, completion: @escaping (Error?) -> Void) {
        // Get the verification id from local storage
        let verificationId = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        
        // Send the code and the verification id to Firebase
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationId,
          verificationCode: code
        )
        
        // Sign in the user
        Auth.auth().signIn(with: credential) { result, error in
            DispatchQueue.main.async {
                // Notify the UI
                completion(error)
            }
        }
        
    }
}
