//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Ernest Margariti on 1/4/23.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
