//
//  TestView.swift
//  LearningApp
//
//  Created by Ernest Margariti on 1/14/23.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex = -1
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQ != nil {
            VStack (alignment: .leading) {
                //Question number
                Text("Question \(model.currentQIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                //Question
                CodeTextView()
                    .padding(.horizontal, 20)
                //Answers
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQ!.answers.count, id: \.self) { index in
                            
                            
                            Button {
                                //Track the selected index
                                selectedAnswerIndex = index
                                
                                
                            } label: {
                                ZStack {
                                    if submitted == false {
                                        
                                        Rectangle()
                                            .foregroundColor(selectedAnswerIndex == index ? .gray : .white)
                                            .cornerRadius(10)
                                            .shadow(radius: 5)
                                            .frame(height: 48)
                                    }
                                    else {
                                        // Answer has been submitted
                                        if index == selectedAnswerIndex && index == model.currentQ?.correctIndex {
                                            //User has selected right answer
                                            //Show green background
                                            Rectangle()
                                                .foregroundColor(.green)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                                .frame(height: 48)
                                        }
                                        else if index == selectedAnswerIndex && index != model.currentQ!.correctIndex {
                                            //User has selected wrong answer
                                            //Show a red background
                                            Rectangle()
                                                .foregroundColor(.red)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                                .frame(height: 48)
                                        }
                                        else if index == model.currentQ!.correctIndex {
                                            //This button is correct answer
                                            //Show reen background
                                            Rectangle()
                                                .foregroundColor(.green)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                                .frame(height: 48)
                                        }
                                        else {
                                            Rectangle()
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                                .frame(height: 48)
                                        }
                                    }
                                    Text(model.currentQ!.answers[index])
                                }
                                }
                                .disabled(submitted)
                            }
                        }
                        .padding()
                        .accentColor(.black)
                    }
                
                //Submit Button
                Button {
                    //Check if answer has been submitted
                    if submitted == true {
                        //Answer has already been submitted, move to next question
                        model.nextQuestion()
                        
                        //Reset the properties
                        submitted = false
                        selectedAnswerIndex = -1
                    }
                    else {
                        //Answer not submitted, submit the answer
                        
                        //Change the submitted state to true
                        submitted =  true
                        
                        //Check the answer, and increment the counter if correct
                        if selectedAnswerIndex == model.currentQ!.correctIndex {
                            numCorrect += 1
                        }
                    }
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(height: 48)
                        Text(buttonText)
                            
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == -1)

            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            //If current question is nil, show result view
            TestResultView(numCorrect: numCorrect)
            
//            //Test hasnt loaded yet (code below is needed to trigger onAppear func in HomeView for TestView
//            ProgressView()
        }
    }
    
    var buttonText:String {
        //Check if answer has been submitted
        if submitted == true {
            if model.currentQIndex + 1 == model.currentModule!.test.questions.count {
                return "Finish Test"
            }
            else {
                return "Next" // or finish
            }
        }
        else {
            return "Submit"
        }
    }
}

