//
//  DatabaseService.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 11/08/22.
//

import Foundation
import Contacts
import Firebase

class DatabaseService {
    func getPlatformUsers(localContacts: [CNContact], completion: @escaping([User])->Void) {
        var platformUsers = [User]()
        
        // Construct array of phone numbers to look up
        var lookupNumbers = localContacts.map { contact in
            return TextHelper.sanitizePhonenumber(contact.phoneNumbers.first?.value.stringValue ?? "")
        }
        
        guard lookupNumbers.count > 0 else {
            completion(platformUsers)
            return
        }
        
        // Query database for phone numbers
        let db = Firestore.firestore()
        
        while(lookupNumbers.count > 0) {
            
            // Get first 10 numbers
            let tenPhoneNumbers = Array(lookupNumbers.prefix(10))
            
            // Drop first 10
            lookupNumbers = Array(lookupNumbers.dropFirst(10))
            
            // Lookup for numbers in firestore
            let query = db.collection("user").whereField("phone", in: tenPhoneNumbers)
            
            query.getDocuments { snapshot, error in
                guard snapshot != nil &&  error == nil else {
                    completion(platformUsers)
                    return
                }
                
                // For each doc create one user
                for doc in snapshot!.documents {
                    if let user = try? doc.data(as: User.self) {
                        // Append user
                        platformUsers.append(user)
                    }
                }
                
                //Exit condition
                if lookupNumbers.count <= 0 {
                    completion(platformUsers)
                }
            }
            
        }
        
    }
}
