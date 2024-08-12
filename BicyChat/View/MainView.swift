//
//  MainView.swift
//  FinalProject
//
//  Created by Koko Jimenez  on 4/19/24.
//

import SwiftUI

struct MainView: View {
    @State private var isDarkMode = false
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "ellipsis.bubble")
                }
            
            CommunityView()
                .tabItem {
                    Label("Community", systemImage: "figure.outdoor.cycle")
                }

            
            ProfileView(isDarkMode: $isDarkMode)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.white)
        .accentColor(Color("RedOrange"))
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
