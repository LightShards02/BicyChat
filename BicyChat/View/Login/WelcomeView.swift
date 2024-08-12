//
//  WelcomeView.swift
//  FinalProject
//
//  Created by Richard Du on 4/20/24.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    // State variables to hold email and password
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("BicyChat")
                        .font(.title)
                    
                    // ReturnUser button
                    NavigationLink(destination: LoginView()) {
                        Text("Return User")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: SignupView()) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    WelcomeView()
}

