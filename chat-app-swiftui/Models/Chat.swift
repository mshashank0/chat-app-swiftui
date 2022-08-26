//
//  Chat.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 18/08/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable {
    
    @DocumentID var id: String?
    var numparticipants: Int
    var participantsids: [String]
    
    @ServerTimestamp var updated: Date?
    var lastmsg: String?
    
    var msgs: [ChatMessage]?
    
}

struct ChatMessage : Codable, Identifiable, Hashable {
   
    @DocumentID var id: String?
    
    var imageurl: String?
    var msg: String
    
    @ServerTimestamp var timestamp: Date?
    
    var senderid: String
}
