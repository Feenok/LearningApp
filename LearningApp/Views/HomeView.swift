//
//  HomeView.swift
//  LearningApp
//
//  Created by Ernest Margariti on 1/4/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { m in
                            VStack (spacing: 20) {
                                
                                NavigationLink(destination: ContentView()
                                    .onAppear(perform: {model.beginModule(m.id)}),
                                               tag: m.id,
                                               selection: $model.currentContentSelected) {
                                    //Learning Card
                                    HomeViewRow(image: m.content.image, title: "Learn \(m.category)", description: m.content.description, count: String(m.content.lessons.count) + " Lessons", time: m.content.time)
                                }
                                
                                
                                NavigationLink(destination: TestView().onAppear(perform: {model.beginTest(m.id)}), tag: m.id, selection: $model.currentTestSelected) {
                                    //Test Card
                                    HomeViewRow(image: m.test.image, title: "\(m.category) Test", description: m.test.description, count: String(m.test.questions.count) + " Lessons", time: m.test.time)
                                }
                                
                            }
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView().environmentObject(ContentModel())
    }
}
