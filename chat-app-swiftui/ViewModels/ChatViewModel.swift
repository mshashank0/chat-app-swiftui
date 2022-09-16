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
    
    @Published var selectedChat: Chat?
    
    @Published var messages = [ChatMessage]()
    
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
    
    /// Search for chat with passed in users. If found, set as selected chat. If not found, create a new chat
    func getChatFor(contacts: [User]) {
                
        // Check the users
        for contact in contacts {
            if contact.id == nil { return }
        }
        
        // Create a set from the ids of the contacts passed in
        let setOfContactIds = Set(arrayLiteral: contacts.map { u in u.id! })
        
        let foundChat = chats.filter { chat in
            
            let setOfParticipantIds = Set(arrayLiteral: chat.participantsids)
            
            return chat.numparticipants == contacts.count + 1 &&
            setOfContactIds.isSubset(of: setOfParticipantIds)
        }
        
        // Found a chat between the user and the contact
        if !foundChat.isEmpty {
            
            // Set as selected chat
            self.selectedChat = foundChat.first!
            
            // Fetch the messages
            getMessages()
        }
        else {
            // No chat was found, create a new one
            
            // Create array of ids of all participants
            var allParticipantIds = contacts.map { u in u.id! }
            allParticipantIds.append(AuthViewModel.getUserId())
            
            let newChat = Chat(id: nil,
                               numparticipants: allParticipantIds.count,
                               participantsids: allParticipantIds,
                               updated: nil, lastmsg: nil, msgs: nil)
            
            // Set as selected chat
            self.selectedChat = newChat
            
            // Save new chat to the database
            databaseService.createChat(chat: newChat) { docId in
                
                // Set doc id from the auto generated document in the database
                self.selectedChat = Chat(id: docId,
                                         numparticipants: allParticipantIds.count,
                                         participantsids: allParticipantIds,
                                         updated: nil, lastmsg: nil, msgs: nil)
                
                // Add chat to the chat list
                self.chats.append(self.selectedChat!)
            }
        }
    }
    
    func clearSelectedChat() {
        self.selectedChat = nil
        self.messages.removeAll()
    }
    
    func getMessages() {
        
        // Check that there's a selected chat
        guard selectedChat != nil else {
            return
        }
        
        databaseService.getAllMessages(chat: selectedChat!) { msgs in
            
            // Set returned messages to property
            self.messages = msgs
        }
        
    }
    
    func sendMessage(msg: String) {
        
        // Check that we have a selected chat
        guard selectedChat != nil else {
            return
        }
        
        databaseService.sendMessage(msg: msg, chat: selectedChat!)
        
    }
    
    func sendPhotoMessage(image: UIImage) {
        
        // Check that we have a selected chat
        guard selectedChat != nil else {
            return
        }
        
        databaseService.sendPhotoMessage(image: image, chat: selectedChat!)
    }
    
    func conversationViewCleanup() {
        databaseService.detachConversationViewListeners()
    }
    
    func chatListViewCleanup() {
        databaseService.detachChatListViewListeners()
    }
    
    // MARK: - Helper Methods
    
    /// Tasks in a list of user ids, removes the user from that list and returns the remaining ids
    func getParticipantIds() -> [String] {
        
        // Check that we have a selected chat
        guard selectedChat != nil else {
            return [String]()
        }
        
        // Filter out the user's id
        let ids = selectedChat!.participantsids.filter { id in
            id != AuthViewModel.getUserId()
        }
        
        return ids
    }

}
