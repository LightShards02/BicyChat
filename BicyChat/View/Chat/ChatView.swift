//
//  ChatView.swift
//  FinalProject
//
//  Created by Richard Du on 5/1/24.
//


import Combine
import SwiftUI

struct ChatView: View {
    @State var messages = DataSource.messages
    @State var newMessage: String = ""
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    @State var isSending: Bool = false
    
    
    var body: some View {
        
            VStack {
                ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
                        }
                    }
                    .onReceive(Just(messages)) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                        
                    }.onAppear {
                        withAnimation {
                            proxy.scrollTo(messages.last, anchor: .bottom)
                        }
                    }.alert(isPresented: $showAlert) {
                        Alert(title: Text(alertMessage))
                    }
                }
                
                // send new message
                HStack {
                    ZStack {
                        TextField("Send a message", text: $newMessage)
                            .textFieldStyle(.roundedBorder)
                            .accentColor(Color("Orange"))
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("LightOrange"), lineWidth: 3)
                                )
                    }
                    .disabled(isSending)
                    
                    Button(action: sendMessage)   {
                        Image(systemName: "paperplane")
                            .foregroundColor(Color("Orange"))
                    }
                    .disabled(isSending)
                }
                .padding()
            }
        }
        
        
        
    }
    
    func sendMessage() {
        if !newMessage.isEmpty{
            messages.append(Message(content: newMessage, isCurrentUser: true))
            isSending = true
            messages.append(Message(content: "loading...", isCurrentUser: false))
            let currentMessage = newMessage
            newMessage = ""
            Task {
                await getReply(message: currentMessage)
                isSending = false
            }
        }
    }
    
    func getReply(message: String) async {
        let data = await fetchResponse(forChat: true, message: message)
        _ = messages.popLast() // remove the loading block
        if (data.good) {
            messages.append(Message(content: data.response!, isCurrentUser: false))
        } else {
            alertMessage = data.error!
            showAlert = true
        }
    }
    
    
}

#Preview {
    ChatView()
}
