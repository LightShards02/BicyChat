//
//  SettingsView.swift
//  FinalProject
//
//  Created by Kevin on 4/20/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isDarkMode: Bool
    @State var isFAQExpanded: Bool = false
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("LightOrange"))
                
                
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
                .foregroundColor(.black)
                .padding(10)
            }
            .frame(width: 340, height: 50)
            
            DisclosureGroup("FAQs", isExpanded: $isFAQExpanded) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("FAQ 1")
                    Text("FAQ 2")
                    Text("FAQ 3")
                    Text("FAQ 4")
                    Text("FAQ 5")
                }
                
            }
            .padding(10)
            .frame(width: 340, height: isFAQExpanded ? 200 : 50)
            .background(Color("LightOrange"))
            .cornerRadius(10)
            .foregroundColor(.black)
            
            Spacer()
        }
        .frame(width: 400, height: 600)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonView())
        
    }
}



#Preview {
    SettingsView(isDarkMode: .constant(false))
}

