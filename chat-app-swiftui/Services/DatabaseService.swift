//
//  DatabaseService.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 11/08/22.
//

import Foundation
import Contacts
import Firebase
import FirebaseStorage

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
            let query = db.collection("users").whereField("phone", in: tenPhoneNumbers)
            
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
    
    func setUserProfileData(firstname: String, lastName: String, photo: UIImage?, completion: @escaping(Bool)->Void) {
        // Ensure that the user is logged in
        guard AuthViewModel.isUserLoggedIn() else {
            // User is not logged in
            return
        }
        
        // Get user's phone number
        let userPhone = TextHelper.sanitizePhonenumber(AuthViewModel.getLoggedInUserPhone())
        
        // Get reference of firestore
        let db = Firestore.firestore()
        
        // Set profile data
        let doc = db.collection("users").document(AuthViewModel.getUserId())
        doc.setData(["firstname" : firstname,
                     "lastname": lastName,
                     "phone": userPhone])
        
        // check if image is not nil
        if let photo = photo {
            // Create storage reference
            let storageRef = Storage.storage().reference()
            
            // Turn our image into data
            let imageData = photo.jpegData(compressionQuality: 0.8)
            
            // Check that we were able to convert it to data
            guard imageData != nil else {
                return
            }
            
            // Specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            
            let _ = fileRef.putData(imageData!, metadata: nil) { meta, error in
                
                if error == nil && meta != nil
                {
                    
                    // Get full url to image
                    fileRef.downloadURL { url, error in
                        // Check for errors
                        if url != nil && error == nil {
                            // Set that image path to the profile
                            doc.setData(["photo": path], merge: true) { error in
                                if error == nil {
                                    // Success, notify caller
                                    completion(true)
                                }
                            }
                        }
                        else {
                            completion(false)
                        }
                    }
                }
                else {
                    // Upload wasn't successful, notify caller
                    completion(false)
                }
            }
        }
    }
    
    func checkUserProfile(_ completion: @escaping (Bool) -> Void) {
        // Check that the user is logged
        guard AuthViewModel.isUserLoggedIn() else {
            return
        }
        
        // Create firebase ref
        let db = Firestore.firestore()
        
        db.collection("users").document(AuthViewModel.getUserId()).getDocument { snapshot, error in
            
            // TODO: Keep the users profile data
            if snapshot != nil && error == nil {
                
                // Notify that profile exists
                completion(snapshot!.exists)
            }
            else {
                // TODO: Look into using Result type to indicate failure vs profile exists
                completion(false)
            }
            
        }
    }
    
    // MARK: - Chat Methods
    
    /// This method returns all chat documents where the logged in user is a participant
    func getAllChats(completion: @escaping([Chat]) -> Void) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Perform a query against the chat collection for any chats where the user is a participant
        let chatsQuery = db.collection("chats")
            .whereField("participantsids",
                        arrayContains: AuthViewModel.getUserId())
        
        chatsQuery.getDocuments { snapshot, error in
            if snapshot != nil && error == nil {
                
                var chats = [Chat]()
                
                // Loop through all the returned chat docs
                for doc in snapshot!.documents {
                    
                    // Parse the data into Chat structs
                    let chat = try? doc.data(as: Chat.self)
                    
                    // Add the chat into the array
                    if let chat = chat {
                        chats.append(chat)
                    }
                }
                
                // Return the data
                completion(chats)
            }
            else {
                print("Error in database retrieval")
            }
        }
    }
    
    /// This method returns all messages for a given chat
    func getAllMessages(chat: Chat, completion: @escaping ([ChatMessage]) -> Void) {
        
        // Check that the id is not nil
        guard chat.id != nil else {
            // Can't fetch data
            completion([ChatMessage]())
            return
        }
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Create the query
        let msgsQuery = db.collection("chats")
            .document(chat.id!)
            .collection("msgs")
            .order(by: "timestamp")
        
        // Perform the query
        msgsQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                // Loop through the msg documents and create ChatMessage instances
                var messages = [ChatMessage]()
                
                for doc in snapshot!.documents {
                    
                    let msg = try? doc.data(as: ChatMessage.self)
                    
                    if let msg = msg {
                        messages.append(msg)
                    }
                }
                
                // Return the results
                completion(messages)
            }
            else {
                print("Error in database retrieval")
            }
        }
    }
    
}
