//
//  ValueEstimateView.swift
//  FinalProject
//
//  Created by Kevin on 5/2/24.
//

import Foundation
import SwiftUI


let stepNum: Int = 5

let brands: [String] = ["I don't know", "Cannondale", "Canyon", "Colnago", "Giant", "Scott", "Specialized", "Trek"]
let years: [String] = Array(2000...2024).map{String($0)}.reversed()
let models: [String: [String]] = [
    "Trek": ["Madone", "Emonda", "Domane", "Pro-caliber", "Slash"]
]
let conditions: [String] = ["Brand New", "Like New", "Good", "Acceptable"]
let scratches: [String] = ["No scratches", "Minor scratches", "Moderate scratches", "Apparent scratches"]

let allOptions: [[String]] = [[""], brands, models["Trek"]!, years, conditions, scratches, [""], [""], [""]]
let questions: [String] = [
    "",
    "What is the brand of your bike?",
    "What is the model of your bike?",
    "What is the estimated production year of your bike?",
    "How's your bike's condition?",
    "Are there any scratches on your bike?",
    "Question 5",
    "Question 6",
    "Question 7"
]
let placeHolders: [String] = ["", "Ex. Trek", "Ex. Madone", "Ex. 2015", "", "", "", ""]

let dropDownQuestions: [Int] = [1, 2, 3]
let multipleChoiceQuestions: [Int] = [4, 5]


struct ValueEstimateView: View {
    
    @State var stepIndex: Int = 1
    @State var selectedOptions: [String] = Array(repeating: "", count: stepNum + 1)
    
    @State var dropDownSearchText: String = ""
    // 0: not expanded; 1: expanded; 2: closed
    @State var dropDownExpanded: Int = 0
    
    @State var multipleChoiceSelect: String = ""
    
    @State var resultVisible: Bool = false
    @State var resultLoaded: Bool = false
    @State var result: String = ""
    
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    var _dropDownExpandedUpdate: Bool {
        if dropDownSearchText == "" {
            dropDownExpanded = 0
        }
        return true
    }
    
    var filteredOptions: [String] {
        if dropDownSearchText.isEmpty {
            if dropDownExpanded == 1 {
                return allOptions[stepIndex]
            }
            return []
        } else {
            if dropDownExpanded == 2 {
                return []
            }
            return allOptions[stepIndex].filter { $0.lowercased().contains(dropDownSearchText.lowercased()) &&
                $0.lowercased() != dropDownSearchText.lowercased() &&
                $0 != "I don't know"
            }
        }
    }
    
    var body: some View {
        ZStack {
            FormView
            
            if resultVisible {
                NavigationView {
                    ResultView
                        .onAppear {
                            fetchResult()
                        }
                        .navigationBarHidden(true)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonView())
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
    
    private var ResultView: some View {
        ZStack {
            Color.clear
                .background(.thinMaterial)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 10)
            VStack {
                Spacer()
                
                Spacer()
                
                Text("Congratulations!")
                    .fontWeight(.bold)
                    .font(.system(size: 28))
                Text("We got your result!")
                    .font(.system(size: 24))
                
                Spacer()
                
                Text("The estimated price range for your bike: ")
                    .font(.system(size: 20))
                
                Spacer()
                
                Text(result)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(Color("RedOrange"))
                    .shadow(color: .white, radius: 5)
                
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color("Orange"))
                    
                    NavigationLink(destination: MainView()) {
                        
                        Text("Back to Home Screen")
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Spacer()
            }
        }
        
    }
    
    func fetchResult() {
        Task {
            let data = await fetchResponse(forChat: false, message: generatePrompt(selectedOptions: selectedOptions))
            if data.good {
                result = data.response ?? ""
            } else {
                alertMessage = data.error ?? "Unknown error"
                showAlert = true
            }
        }
    }
    
    
    private var FormView: some View {
        VStack {
            HStack {
                ForEach(1...stepNum, id: \.self) { index in
                    Button(action: {
                        self.stepIndex = index
                    }) {
                        Text("\(index)")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(buttonColor(index: index))
                            .clipShape(Circle())
                    }
                    .disabled(stepIndex < index)
                }
            }
            .padding()
            
            Spacer()
            
            QuestionBodyView
            
            Spacer()
            
            Spacer()
            
            HStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("LightOrange"))
                        .frame(height: 60)
                    
                    Button(action: {
                        selectedOptions[stepIndex] = getCurrentPageResult()
                        print(selectedOptions)
                        if stepIndex > 1 {
                            stepIndex -= 1
                        }
                        reloadCurrentForm()
                    }, label: {
                        Text("Previous")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    })
                    .foregroundColor(.black)
                    .padding(10)
                }
                .frame(height: 30)
                .padding()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(
                            getCurrentPageResult() == "" ? Color(.lightGray) : Color("Orange"))
                        .frame(height: 60)
                    Button(action: {
                        selectedOptions[stepIndex] = getCurrentPageResult()
                        print(selectedOptions)
                        if stepIndex < stepNum {
                            stepIndex += 1
                        } else {
                            resultVisible = true
                        }
                        reloadCurrentForm()
                    }, label: {
                        Text(stepIndex == stepNum ? "See Results" : "Next")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    })
                    .disabled(getCurrentPageResult() == "")
                    .foregroundColor(.black)
                    .padding(10)
                }
                .padding()
            }
        }
    }
    
    
    private var QuestionBodyView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .shadow(radius: 5)
                .foregroundColor(Color("LightOrange"))
            VStack {
                Spacer()
                Text(questions[stepIndex])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 32))
                //TODO: make this into asset
                    .foregroundColor(.white)
                    .padding(20)
                    
                if dropDownQuestions.contains(stepIndex) {
                    AutoHintTextFieldView
                } else if multipleChoiceQuestions.contains(stepIndex) {
                    MultipleChoiceView
                }
                
                Spacer()
            }
        }
        .padding(15)
    }
    
    var AutoHintTextFieldView: some View {
        VStack {
            HStack {
                TextField(placeHolders[stepIndex], text: $dropDownSearchText)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 20))
                    .accentColor(Color("Orange"))
                Button(action: {
                    if dropDownExpanded == 0 {
                        dropDownExpanded = 1
                    } else if dropDownExpanded == 1 {
                        dropDownExpanded = dropDownSearchText.isEmpty ? 0 : 2
                    } else if dropDownExpanded == 2 {
                        dropDownExpanded = 1
                    }
                }, label: {
                    Image(systemName: "triangle.fill")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(dropDownExpanded == 1 ? 0 : 180))
                    
                })
            }
            
            ScrollView {
                VStack() {
                    ForEach(filteredOptions, id: \.self) {
                        option in
                        Button(action: {
                            dropDownSearchText = option
                        },label:{ Text(option)
                                .foregroundColor(.white)
                        })
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 200)
            
        }
        .padding(20)
    }
    
    var MultipleChoiceView: some View {
        VStack {
            ForEach(allOptions[stepIndex], id: \.self) {
                option in
                Button(action: {
                    multipleChoiceSelect = option
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(option == multipleChoiceSelect ? Color("Orange") : Color("Orange").opacity(0.5))
                            .frame(height: 50)
                        Text(option)
                            .foregroundColor(.white)
                    }
                })
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            }
        }
    }
    

    
    
    private func buttonColor(index: Int) -> Color {
        if index < stepIndex {
            return Color("LightOrange")
        } else if index == stepIndex {
            return Color("Orange")
        } else {
            // TODO: make this into asset
            return .gray
        }
    }
    
    private func getCurrentPageResult() -> String {
        
        if (dropDownQuestions.contains(stepIndex)) {
            return dropDownSearchText
        } else if (multipleChoiceQuestions.contains(stepIndex)) {
            return multipleChoiceSelect
        } else {
            
        }
        return ""
    }
    
    private func reloadCurrentForm() {
        if (dropDownQuestions.contains(stepIndex)) {
            dropDownSearchText = selectedOptions[stepIndex]
            dropDownExpanded = 0
        } else if (multipleChoiceQuestions.contains(stepIndex)) {
            multipleChoiceSelect = selectedOptions[stepIndex]
        } else {
            
        }
    }
}


#Preview {
    ValueEstimateView()
}
