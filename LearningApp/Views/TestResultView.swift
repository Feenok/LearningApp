//
//  TestResultView.swift
//  LearningApp
//
//  Created by Ernest Margariti on 1/17/23.
//

import SwiftUI

struct TestResultView: View {
    @EnvironmentObject var model:ContentModel
    
    var numCorrect:Int
    
    var resultHeading: String {
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        if pct >= 0.7 {
            return "Awesome! Keep up the good work!"
        }
        if pct >= 0.5 && pct < 0.7 {
            return "You're almost there, continue learing!"
        }
        else {
            return "Give it another shot!"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(resultHeading)
                .font(.title)
                .multilineTextAlignment(.center)
            
            Spacer()
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions correct")
            Spacer()
            Button {
                //Send user back to the home view
                model.currentTestSelected = nil
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(height: 48)
                    Text("Complete")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                Spacer()
            }

        }
    }
}

