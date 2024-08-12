//
//  ProfileView.swift
//  FinalProject
//
//  Created by Koko Jimenez  on 4/18/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Binding var isDarkMode: Bool
    @StateObject var viewModel = ProfileModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color("Orange"))
                    .padding(.top, 40)
                
                Spacer()
                
                EditableCircularProfileImage(viewModel: viewModel)
                
                ProfileInfoSection
                
                Spacer()
            }
        }
        
    }
    
    
    private var ProfileInfoSection: some View {
        
        VStack(alignment: .center) {
            
            HStack {
                Text("Yuxuan Du")
                    .font(.title2)
                    .foregroundColor(Color("Orange"))
                Button(action:{}, label:{
                    Image(systemName: "pencil")
                        .foregroundColor(.black)
                        .bold()
                })
            }
            .padding(.bottom)
            
            Button(action:{}, label:{
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 350, height: 70)
                    .overlay {
                        HStack {
                            Image(systemName: "square.grid.2x2")
                                .bold()
                            Text("Profile")
                        }
                        .foregroundStyle(.black)
                    }
            })
            
            
            
            Button(action:{}, label:{
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 350, height: 70)
                    .overlay {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                                .bold()
                            Text("History")
                        }
                        .foregroundStyle(.black)
                    }
            })
            
            
            
            Button(action:{}, label:{
                NavigationLink(destination: SettingsView(isDarkMode: $isDarkMode)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 350, height: 70)
                        
                        
                        HStack {
                            Image(systemName: "gear")
                                .bold()
                            Text("Settings")
                        }
                        .foregroundStyle(.black)
                    }
                    
                }
            })
            
            
            Button(action:{}, label:{
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 350, height: 70)
                    .overlay {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                                .bold()
                            Text("Log Out")
                        }
                        .foregroundStyle(.black)
                        
                    }
            })
            
        }
        .foregroundColor(Color("LightOrange"))
        .padding(.top, 30)
    }
}


#Preview {
    ProfileView(isDarkMode: .constant(false))
}
