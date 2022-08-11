//
//  TextHelper.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 11/08/22.
//

import Foundation

class TextHelper {
    static func sanitizePhonenumber(_ phone: String) -> String {
       return phone
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
}
