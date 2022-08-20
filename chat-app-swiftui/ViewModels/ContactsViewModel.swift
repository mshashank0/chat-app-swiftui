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
    
    private var filterText = ""
    @Published var filteredUsers = [User]()
    
    private var localContacts = [CNContact]()
    
    func getLocalContacts() {
        
        // Perform fetching contacts from store asynchronously, so that UI doesnt get blocked
        DispatchQueue(label: "getcontacts").async {
            do {
                //Ask for permission
                let store = CNContactStore()
                
                self.localContacts = []
                
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
                        
                        // Set the filtered list
                        self.filterContacts(filterBy: self.filterText)
                    }
                }
            }
            catch {
                
            }
        }
        
    }
    
    func filterContacts(filterBy: String) {
        
        // Store parameter into property
        self.filterText = filterBy
        
        // If filter text is empty, then reveal all users
        if filterText == "" {
            self.filteredUsers = users
            return
        }
        
        // Run the users list through the filter term to get a list of filtered users
        self.filteredUsers = users.filter({ user in
            
            // Criteria for including this user into filtered users list
            user.firstname?.lowercased().contains(filterText) ?? false ||
            user.lastname?.lowercased().contains(filterText) ?? false ||
            user.phone?.lowercased().contains(filterText) ?? false
           
        })
    }
    
    func getParticipants(ids: [String]) -> [User] {
        
        // Filter out the users list for only the participants based on ids passed in
        let foundUsers = users.filter { user in
            
            if user.id == nil {
                return false
            }
            else {
                return ids.contains(user.id!)
            }
                
        }
        
        return foundUsers
    }
}
