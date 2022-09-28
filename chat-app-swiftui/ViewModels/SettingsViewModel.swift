//
//  SettingsViewModel.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 28/09/22.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @AppStorage(Constants.DarkModeKey) var isDarkMode = false
    
    var databaseService = DatabaseService()
    
    func deactivateAccount(completion: @escaping () -> Void) {
        
        // Call the database service
        databaseService.deactivateAccount {
            
            // Deactivation is complete
            completion()
        }
    }
}
