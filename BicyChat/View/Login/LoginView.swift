//
//  LoginView.swift
//  FinalProject
//
//  Created by Richard Du on 4/20/24.
//


import SwiftUI
import SwiftData

struct LoginView: View {
    // State variables to hold email and password
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToSecondView = false
    @State private var showAlert: Bool = false
    @State private var loginSuccess: Bool = false
    @State private var path: [Account] = []
    @State private var account: Account = Account(id: "default", pw: "")
    @Environment(\.modelContext) private var context
    @Query var allAccounts: [Account]
    
    
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
                    
                    // Textfield for email
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    
                    // Textfield for password
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    // Login button
                    Button (action: {
                        if (!allAccounts.isEmpty) {
                            
                            print(account)
                            for acc in allAccounts {
                                if acc.id == email && acc.pw == password {
                                    navigateToSecondView = true
                                    showAlert = true
                                    loginSuccess = true
                                    account = acc
                                    return
                                }
                            }
                            showAlert = true
                        }
                    }) {
                        Text("Login")
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Result"), message: Text("Log in \(loginSuccess ? "successful" : "unsuccessful")"), dismissButton: .default(Text("OK")))
                            }
                        
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: MainView()) {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color("Orange"))
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    //                    NavigationStack(path: $path) {
                    //                        NavigationLink("", value: account)
                    //                    }
                    //                    .navigationDestination(for: Account.self) {
                    //                        account in MainView()
                    //                    }
                    
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
        LoginView()
}

