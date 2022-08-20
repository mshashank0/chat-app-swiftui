//
//  DateHelper.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 20/08/22.
//

import Foundation

class DateHelper {
    
    static func chatTimestampFrom(date: Date?) -> String {
        
        guard date != nil else {
            return ""
        }
        
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        
        return df.string(from: date!)
    }
    
}
