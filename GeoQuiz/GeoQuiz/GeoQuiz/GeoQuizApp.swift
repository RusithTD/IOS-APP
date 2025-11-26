//
//  GeoQuizApp.swift
//  GeoQuiz
//
//  Created by STUDENT on 2025-11-22.
//

import SwiftUI

@main
struct GeoQuizApp: App {
    @StateObject private var quizViewModel = QuizViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quizViewModel)
        }
    }
}
