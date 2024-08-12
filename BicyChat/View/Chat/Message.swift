//
//  Message.swift
//  FinalProject
//
//  Created by Richard Du on 5/1/24.


import Foundation

struct Message: Hashable {
    var id = UUID()
    var content: String
    var isCurrentUser: Bool
}

struct DataSource {
    
    static let messages = [
        Message(content: "Hello! How can I assist you today?", isCurrentUser: false)
    ]
}
