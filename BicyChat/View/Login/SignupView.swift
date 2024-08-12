//
//  SignupView.swift
//  FinalProject
//
//  Created by Richard Du on 4/20/24.
//

import SwiftUI
import SwiftData

struct SignupView: View {
    // State variables to hold email and password
    @State var newemail: String = ""
    @State var newpassword: String = ""
    @State private var navigateToSecondView = false
    @State private var showAlert: Bool = false
    @Environment(\.modelContext) private var context
    @Query var account: [Account]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Create a new BicyChat account")
                        .font(.title)
                    
                    // Textfield for email
                    TextField("Email", text: $newemail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    
                    // Textfield for password
                    SecureField("Password", text: $newpassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    // Login button
                    Button("Create Account") {
                        // Action to perform before navigation
                        addAccount(newemail: newemail, newpassword: newpassword, context: context)
                        
                        self.showAlert = true
                        
                        // Trigger navigation
                        self.navigateToSecondView = true
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Result"), message: Text("Your new account is \((account.last ?? Account(id: "Account doesn't exist", pw: "")).id)"), dismissButton: .default(Text("OK")))
                    }

                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("Orange"))
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
                    .padding(.horizontal)

                    NavigationLink(destination: LoginView()/*isActive: $navigateToSecondView*/) {
                        
                        Text("Go to Login")
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
    SignupView()
}
