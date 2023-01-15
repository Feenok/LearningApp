//
//  TestView.swift
//  LearningApp
//
//  Created by Ernest Margariti on 1/14/23.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.currentQ != nil {
            VStack {
                //Question number
                Text("Question \(model.currentQIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                //Question
                CodeTextView()
                
                //Answers
                //Button
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            //Test hasnt loaded yet (this is needed to trigger onAppear func in HomeView for TestView
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
