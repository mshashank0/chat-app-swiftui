//
//  User.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 10/08/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var firstname: String?
    var lastname: String?
    var phone: String?
    var photo: String?
}
