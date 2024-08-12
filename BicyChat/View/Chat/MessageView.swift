//
//  MessageView.swift
//  FinalProject
//
//  Created by Richard Du on 5/1/24.
//


import SwiftUI

struct MessageView : View {
    var currentMessage: Message
    
    var body: some View {
        if !currentMessage.isCurrentUser {
            HStack(alignment: .bottom, spacing: 10) {
                Image("gptAvatar")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                ContentMessageView(contentMessage: currentMessage.content,
                            isCurrentUser: currentMessage.isCurrentUser)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        } else {
            HStack(alignment: .bottom, spacing: 10) {
                Spacer()
                ContentMessageView(contentMessage: currentMessage.content,
                            isCurrentUser: currentMessage.isCurrentUser)
                Image("avatar")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
            }
            .padding()
        }
    }
}


#Preview {
    MessageView(currentMessage: Message(content: "This is a single message cell with avatar. If user is current user, we won't display the avatar.", isCurrentUser: true))
}
