//
//  ChatViewModel.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 18/08/22.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
   
    @Published var chats = [Chat]()
    
    var databaseService = DatabaseService()
    
    init() {
        // Retrieve chats when ChatViewModel is created
        getChats()
    }
    
    func getChats() {
        
        databaseService.getAllChats { chats in
            self.chats = chats
        }
    }
}
