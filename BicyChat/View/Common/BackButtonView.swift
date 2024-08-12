//
//  BackButtonView.swift
//  FinalProject
//
//  Created by Kevin on 5/2/24.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                Text("Back")
            }
            .foregroundColor(Color("Orange"))
        }
    }
}

