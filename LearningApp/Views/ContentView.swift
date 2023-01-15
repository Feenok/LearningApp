//
//  ContentView.swift
//  LearningApp
//
//  Created by Ernest Margariti on 1/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                
                //Confirm that currentModule is set
                if model.currentModule != nil {
                    ForEach (0..<model.currentModule!.content.lessons.count) { index in
                        
                        NavigationLink {
                            ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(lessonIndex: index)
                                })
                        } label: {
                            ContentViewRow(index: index)
                        }
                    }
                }
            }
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
        
    }
}
