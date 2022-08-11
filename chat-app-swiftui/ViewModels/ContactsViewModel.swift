//
//  ContactsViewModel.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 10/08/22.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    private var localContacts = [CNContact]()
    
    func getLocalContacts() {
        
        // Perform fetching contacts from store asynchronously, so that UI doesnt get blocked
        DispatchQueue(label: "getcontacts").async {
            do {
                //Ask for permission
                let store = CNContactStore()
                
                //List fo keys we want to get
                let keys = [CNContactPhoneNumbersKey,
                            CNContactGivenNameKey,
                            CNContactFamilyNameKey] as [CNKeyDescriptor]
                
                //Create a fetch request
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                
                //Get contacts on user phone
                try store.enumerateContacts(with: fetchRequest) { contact, success in
                    self.localContacts.append(contact)
                }
                
                DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                    DispatchQueue.main.async {
                        self.users = platformUsers
                    }
                }
            }
            catch {
                
            }
        }
        
    }
}
