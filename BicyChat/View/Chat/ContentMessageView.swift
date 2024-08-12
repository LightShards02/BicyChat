//
//  ContentMessageView.swift
//  FinalProject
//
//  Created by Richard Du on 5/1/24.
//

import SwiftUI

struct ContentMessageView: View {
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color("LightOrange") : Color(UIColor.systemGray6 ))
            .cornerRadius(10)
    }
}

#Preview {
    ContentMessageView(contentMessage: "This is a single message cell.", isCurrentUser: false)
}
