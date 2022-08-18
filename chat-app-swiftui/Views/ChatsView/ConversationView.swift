//
//  ConversationView.swift
//  chat-app-swiftui
//
//  Created by Shashank Mishra on 18/08/22.
//

import SwiftUI

struct ConversationView: View {
    
    @Binding var isChatShowing: Bool
    
    @State var chatMessage = ""
    
    var body: some View {
        
        VStack {
            
            // Chat header
            HStack {
                VStack (alignment: .leading) {
                    
                    // Back arrow
                    Button {
                        // Dismiss chat window
                        isChatShowing = false
                        
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color("text-header"))
                    }
                    .padding(.bottom, 16)
                    
                    // Name
                    Text("Chris Ching")
                        .font(Font.chatHeading)
                        .foregroundColor(Color("text-header"))
                }
                
                Spacer()
                
                // Profile image
                ProfilePicView(user: User())
            }
            .padding(.horizontal)
            .frame(height: 104)
            
            // Chat log
            ScrollView {
                
                VStack (spacing: 24) {
                    
                    // Their message
                    HStack {
                        
                        // Message
                        Text("Lorem ipsum dolor sit amet")
                            .font(Font.bodyParagraph)
                            .foregroundColor(Color("text-primary"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-secondary"))
                            .cornerRadius(30, corners: [.topLeft, .topRight, .bottomRight])
                        
                        Spacer()
                        
                        // Timestamp
                        Text("9:41")
                            .font(Font.smallText)
                            .foregroundColor(Color("text-timestamp"))
                            .padding(.leading)
                    }
                    
                    // Your message
                    HStack {
                        
                        // Timestamp
                        Text("9:41")
                            .font(Font.smallText)
                            .foregroundColor(Color("text-timestamp"))
                            .padding(.trailing)
                        
                        Spacer()
                        
                        // Message
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam")
                            .font(Font.bodyParagraph)
                            .foregroundColor(Color("text-button"))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            .background(Color("bubble-primary"))
                            .cornerRadius(30, corners: [.topLeft, .topRight, .bottomLeft])
                        
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
            }
            .background(Color("background"))
            
            // Chat message bar
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                
                HStack {
                    // Camera button
                    Button {
                        // TODO: Show picker
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-secondary"))
                    }

                    // Textfield
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(Color("date-pill"))
                            .cornerRadius(50)
                        
                        TextField("Type your message", text: $chatMessage)
                            .foregroundColor(Color("text-input"))
                            .font(Font.bodyParagraph)
                            .padding(10)
                        
                        // Emoji button
                        HStack {
                            Spacer()
                            
                            Button {
                                // Emojis
                            } label: {
                                Image(systemName: "face.smiling")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("text-input"))
                            }
                        }
                        .padding(.trailing, 12)
                        
                        

                    }
                    .frame(height: 44)
                    
                    
                    // Send button
                    Button {
                        // TODO: Send message
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(Color("icons-primary"))
                    }

                }
                .padding(.horizontal)
            }
            .frame(height: 76)
        }
        
        
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(isChatShowing: .constant(false))
    }
}
