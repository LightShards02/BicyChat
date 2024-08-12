//
//  SizingView.swift
//  FinalProject
//
//  Created by Richard Du on 5/2/24.
//

import SwiftUI

struct SizingView: View {
    @State private var height: Int = 170
    @State private var inseam: Int = 80
    @State private var showAlert: Bool = false
    @State private var sum: Double = 0
    @State private var size: String = ""

    var body: some View {
        VStack {
            Text("Find the right size of your bike")
                .font(.title)
                .bold()
                .foregroundStyle(Color("Orange"))
                .padding()
            Image("sizeMeasure")
                .resizable()
                .scaledToFit()
            
            Text("Select your height (cm)")
                .font(.title2)
                .bold()
                .foregroundStyle(Color("Orange"))
                .padding()
 
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("LightOrange"))
                
                Menu("\(height)") {
                    ForEach(100...200, id: \.self) { value in
                        Button("\(Int(value))", action: { height = value })
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .accentColor(.white)
            }
            .frame(width: 340, height: 50)
            .padding()
            
            Text("Select your inseam (cm)")
                .font(.title2)
                .bold()
                .foregroundStyle(Color("Orange"))
                .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("LightOrange"))
                
                Menu("\(inseam)") {
                    ForEach(50...110, id: \.self) { value in
                        Button("\(value)", action: { inseam = value })
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .accentColor(.white)
            }
            .frame(width: 340, height: 50)
            .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("Orange"))
                
                Button("Calculate Size") {
                    if (height < 155) {
                        self.sum = Double(inseam) * 0.67 - Double(height) * 0.01
                    } else if (height > 190) {
                        self.sum = Double(inseam) * 0.67 + Double(height) * 0.01
                    } else {
                        self.sum = Double(inseam) * 0.67
                    }
                    switch self.sum {
                    case ...47:
                        self.sum = 46
                    case 47...49:
                        self.sum = 48
                    case 49...51:
                        self.sum = 50
                    case 51...53:
                        self.sum = 52
                    case 53...55:
                        self.sum = 54
                    case 55...57:
                        self.sum = 56
                    case 57...59:
                        self.sum = 58
                    case 59...61:
                        self.sum = 60
                    case 61...:
                        self.sum = 62
                    default:
                        self.sum = 54
                    }
                    self.size = String(format: "%.0f", self.sum)
                    self.showAlert = true
                }

                .foregroundColor(.white)
                .font(.title3)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Result"), message: Text("The appropriate size should be \(size)cm"), dismissButton: .default(Text("OK")))
                }
            }
            .frame(width: 340, height: 50)
            .padding()
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonView())
    }
}

#Preview {
    SizingView()
}
