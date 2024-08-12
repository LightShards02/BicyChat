//
//  ContentView.swift
//  FinalProject
//
//  Created by Koko Jimenez  on 4/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomePage
        }
        
    }
    
    private var HomePage: some View {
        VStack (alignment:.trailing) {
            Text("How can we help you?")
                .font(.title)
                .bold()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding([.top, .bottom, .leading], 35)
            
            Spacer()
            
            Group {
                
                NavigationLink(destination: ValueEstimateView(), label: {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 400, height: 150)
                                .padding(.trailing, -100)
                            Image(systemName: "bicycle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .offset(x: 50, y: 0)
                        }
                        Text("Find your bike")
                            .padding(.bottom, 30)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 40)
                    }
                })
                
                NavigationLink(destination: SizingView(), label: {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 400, height: 150)
                                .padding(.trailing, -100)
                            Image(systemName: "ruler")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .offset(x: 100, y: 0)
                        }
                        Text("Find your size")
                            .padding(.bottom, 30)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 40)
                    }
                })

                NavigationLink(destination: ValueEstimateView(), label: {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 400, height: 150)
                                .padding(.trailing, -100)
                            Image(systemName: "dollarsign.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .offset(x: 50, y: 0)
                        }
                        Text("Value Estimator")
                            .padding(.bottom, 30)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 40)
                    }
                })

            }
            .font(.title3)
            
            Spacer()
            
        }
        .foregroundStyle(Color("Orange"))
    }
    
}



#Preview {
    ContentView()
}
