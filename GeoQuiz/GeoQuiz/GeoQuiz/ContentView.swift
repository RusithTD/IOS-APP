//
//  ContentView.swift
//  GeoQuiz
//
//  Created by STUDENT on 2025-11-22.
//

import SwiftUI
import MapKit
import Combine
import AVFoundation

// Represents the difficulty of the quiz
enum GameLevel: Int, CaseIterable, Identifiable {
    case easy = 1
    case medium
    case hard

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }

    var timeLimit: Int {
        switch self {
        case .easy:
            return 20
        case .medium:
            return 15
        case .hard:
            return 10
        }
    }
}

// Single quiz question, including the map coordinate and answer options
struct GeoQuestion: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
    let options: [String]
    let correctIndex: Int
    let level: GameLevel
}

// Static bank of questions grouped by difficulty
struct QuestionBank {
    static let all: [GeoQuestion] = [
        // Easy – very famous world cities and landmarks
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 48.8584, longitude: 2.2945),
            options: ["Paris", "London", "Berlin", "Rome"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 40.6892, longitude: -74.0445),
            options: ["New York", "Los Angeles", "Chicago", "Miami"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: -33.8568, longitude: 151.2153),
            options: ["Sydney", "Melbourne", "Auckland", "Perth"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 51.5007, longitude: -0.1246),
            options: ["London", "Dublin", "Manchester", "Cardiff"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
            options: ["Rome", "Milan", "Florence", "Naples"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
            options: ["Cairo", "Riyadh", "Casablanca", "Doha"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 39.9042, longitude: 116.4074),
            options: ["Beijing", "Shanghai", "Seoul", "Tokyo"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173),
            options: ["Moscow", "Warsaw", "Prague", "Budapest"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: -22.9068, longitude: -43.1729),
            options: ["Rio de Janeiro", "Lisbon", "Buenos Aires", "Santiago"],
            correctIndex: 0,
            level: .easy
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 35.6762, longitude: 139.6503),
            options: ["Tokyo", "Osaka", "Seoul", "Kyoto"],
            correctIndex: 0,
            level: .easy
        ),

        // Medium – well known global cities
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            options: ["San Francisco", "Seattle", "Los Angeles", "Portland"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832),
            options: ["Toronto", "Montreal", "Vancouver", "Ottawa"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: -33.9249, longitude: 18.4241),
            options: ["Cape Town", "Durban", "Nairobi", "Johannesburg"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198),
            options: ["Singapore", "Kuala Lumpur", "Bangkok", "Manila"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708),
            options: ["Dubai", "Abu Dhabi", "Doha", "Kuwait City"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 22.3193, longitude: 114.1694),
            options: ["Hong Kong", "Shanghai", "Taipei", "Guangzhou"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332),
            options: ["Mexico City", "Lima", "Bogotá", "Caracas"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018),
            options: ["Bangkok", "Hanoi", "Phnom Penh", "Ho Chi Minh City"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 41.3851, longitude: 2.1734),
            options: ["Barcelona", "Valencia", "Madrid", "Seville"],
            correctIndex: 0,
            level: .medium
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784),
            options: ["Istanbul", "Athens", "Sofia", "Bucharest"],
            correctIndex: 0,
            level: .medium
        ),

        // Hard – more specific or less obvious places
        GeoQuestion(
            title: "Which famous place is this?",
            coordinate: CLLocationCoordinate2D(latitude: -13.1631, longitude: -72.5450),
            options: ["Machu Picchu", "Cusco", "Lima", "Quito"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which city is this?",
            coordinate: CLLocationCoordinate2D(latitude: 64.1466, longitude: -21.9426),
            options: ["Reykjavik", "Oslo", "Helsinki", "Stockholm"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which famous place is this?",
            coordinate: CLLocationCoordinate2D(latitude: 29.9792, longitude: 31.1342),
            options: ["Giza Pyramids", "Petra", "Luxor", "Cairo Tower"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which famous place is this?",
            coordinate: CLLocationCoordinate2D(latitude: 30.3285, longitude: 35.4444),
            options: ["Petra", "Jerusalem", "Amman", "Damascus"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which temple complex is this?",
            coordinate: CLLocationCoordinate2D(latitude: 13.4125, longitude: 103.8667),
            options: ["Angkor Wat", "Borobudur", "Bagan", "Shwedagon"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which national park is this?",
            coordinate: CLLocationCoordinate2D(latitude: -2.3333, longitude: 34.8333),
            options: ["Serengeti", "Kruger", "Masai Mara", "Etosha"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which mountain town is this?",
            coordinate: CLLocationCoordinate2D(latitude: 51.1784, longitude: -115.5708),
            options: ["Banff", "Whistler", "Zermatt", "Chamonix"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which island is this?",
            coordinate: CLLocationCoordinate2D(latitude: 36.3932, longitude: 25.4615),
            options: ["Santorini", "Mykonos", "Crete", "Rhodes"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which village is this?",
            coordinate: CLLocationCoordinate2D(latitude: 47.5622, longitude: 13.6493),
            options: ["Hallstatt", "Interlaken", "Innsbruck", "Lucerne"],
            correctIndex: 0,
            level: .hard
        ),
        GeoQuestion(
            title: "Which island is this?",
            coordinate: CLLocationCoordinate2D(latitude: -16.5004, longitude: -151.7415),
            options: ["Bora Bora", "Fiji", "Tahiti", "Samoa"],
            correctIndex: 0,
            level: .hard
        )
    ]

    // Returns questions for a level, shuffling options so the correct
    // answer is not always in the same position.
    static func questions(for level: GameLevel) -> [GeoQuestion] {
        let base = all.filter { $0.level == level }

        return base.map { question in
            let indexedOptions = Array(question.options.enumerated())
            var shuffled = indexedOptions
            shuffled.shuffle()

            let shuffledOptions = shuffled.map { $0.element }
            let newCorrectIndex = shuffled.firstIndex { pair in
                pair.0 == question.correctIndex
            } ?? 0

            return GeoQuestion(
                title: question.title,
                coordinate: question.coordinate,
                options: shuffledOptions,
                correctIndex: newCorrectIndex,
                level: question.level
            )
        }
    }
}

// Central game state and logic shared across views
class QuizViewModel: ObservableObject {
    @Published var currentLevel: GameLevel = .easy
    @Published var questions: [GeoQuestion] = []
    @Published var currentIndex: Int = 0
    @Published var currentQuestion: GeoQuestion?
    @Published var score: Int = 0
    @Published var timeRemaining: Int = 0
    @Published var isGameOver: Bool = false
    @Published var didCompleteAllQuestions: Bool = false
    @Published var correctAnswers: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var lastAnswerCorrect: Bool? = nil
    @Published var highScores: [GameLevel: Int] = [:]
    @Published var navigateHomeRequested: Bool = false
    @Published var currentHint: String? = nil
    @Published var hasRequestedHint: Bool = false

    let questionsPerLevel: Int = 10

    init() {
        loadHighScores()
    }

    func start(level: GameLevel) {
        currentLevel = level
        let baseQuestions = QuestionBank.questions(for: level)

        guard !baseQuestions.isEmpty else {
            questions = []
            currentQuestion = nil
            score = 0
            timeRemaining = 0
            isGameOver = true
            didCompleteAllQuestions = false
            return
        }

        var generated: [GeoQuestion] = []
        while generated.count < questionsPerLevel {
            generated.append(contentsOf: baseQuestions.shuffled())
        }

        questions = Array(generated.prefix(questionsPerLevel))

        currentIndex = 0
        score = 0
        correctAnswers = 0
        isGameOver = false
        didCompleteAllQuestions = false
        selectedAnswerIndex = nil
        lastAnswerCorrect = nil
        currentHint = nil
        hasRequestedHint = false
        loadQuestion()
    }

    private func loadQuestion() {
        guard questions.indices.contains(currentIndex) else {
            didCompleteAllQuestions = true
            endGame()
            return
        }
        currentQuestion = questions[currentIndex]
        timeRemaining = currentLevel.timeLimit
        selectedAnswerIndex = nil
        lastAnswerCorrect = nil
        currentHint = nil
        hasRequestedHint = false
    }

    func submitAnswer(index: Int) {
        guard !isGameOver, let question = currentQuestion else { return }
        // Ignore taps after an answer has already been chosen
        if selectedAnswerIndex != nil { return }

        selectedAnswerIndex = index

        let isCorrect = index == question.correctIndex
        lastAnswerCorrect = isCorrect

        if isCorrect {
            score += 10
            correctAnswers += 1
        }

        let questionIndexAtAnswer = currentIndex

        // Small delay so the player can see green/red feedback
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            guard !self.isGameOver, self.currentIndex == questionIndexAtAnswer else { return }

            if isCorrect {
                if self.currentIndex + 1 >= self.questionsPerLevel {
                    self.didCompleteAllQuestions = true
                    self.endGame()
                } else {
                    self.currentIndex += 1
                    self.loadQuestion()
                }
            } else {
                self.endGame()
            }
        }
    }

    func tickTimer() {
        guard !isGameOver else { return }

        if timeRemaining > 0 {
            timeRemaining -= 1

            if timeRemaining == 0 {
                endGame()
            }
        }
    }

    private func goToNextQuestion() {
        if currentIndex + 1 < questions.count {
            currentIndex += 1
            loadQuestion()
        } else {
            didCompleteAllQuestions = true
            endGame()
        }
    }

    private func endGame() {
        isGameOver = true
        currentQuestion = nil
        updateHighScoreIfNeeded()
    }

    private func key(for level: GameLevel) -> String {
        "highscore_\(level.rawValue)"
    }

    func loadHighScores() {
        var dict: [GameLevel: Int] = [:]

        for level in GameLevel.allCases {
            dict[level] = UserDefaults.standard.integer(forKey: key(for: level))
        }

        highScores = dict
    }

    private func updateHighScoreIfNeeded() {
        let currentBest = highScores[currentLevel] ?? 0

        if score > currentBest {
            highScores[currentLevel] = score
            UserDefaults.standard.set(score, forKey: key(for: currentLevel))
        }
    }

    func requestHint() {
        guard let question = currentQuestion, !hasRequestedHint else { return }
        let service = AIHintService()
        currentHint = service.generateHint(for: question.title, options: question.options)
        hasRequestedHint = true
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: QuizViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.blue, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 32) {
                    Spacer(minLength: 40)

                    VStack(spacing: 12) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 60))
                            .foregroundColor(.white)

                        Text("Geo Quiz")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)

                        Text("Guess the place from the map!")
                            .foregroundColor(.white.opacity(0.85))
                            .multilineTextAlignment(.center)
                    }

                    VStack(spacing: 16) {
                        NavigationLink(destination: LevelSelectView()) {
                            Text("Start Game")
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white.opacity(0.7), lineWidth: 1.2)
                                )
                                .cornerRadius(14)
                                .foregroundColor(.white)
                        }

                        NavigationLink(destination: HighScoresView()) {
                            Text("High Scores")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.08))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                )
                                .cornerRadius(14)
                                .foregroundColor(.white)
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .tint(.white)
        }
    }
}

struct LevelSelectView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(GameLevel.allCases) { level in
                        NavigationLink(destination: QuizView(level: level)) {
                            HStack(spacing: 16) {
                                Image(systemName: iconName(for: level))
                                    .font(.system(size: 28))
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.white)
                                    .background(iconColor(for: level).opacity(0.8))
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(level.title)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Text("Time limit: \(level.timeLimit)s")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.8))
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding()
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Choose Level")
        .onChange(of: viewModel.navigateHomeRequested) { toHome in
            if toHome {
                dismiss()
                viewModel.navigateHomeRequested = false
            }
        }
    }

    private func iconName(for level: GameLevel) -> String {
        switch level {
        case .easy:
            return "leaf.fill"
        case .medium:
            return "globe.europe.africa.fill"
        case .hard:
            return "flame.fill"
        }
    }

    private func iconColor(for level: GameLevel) -> Color {
        switch level {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
}

struct QuizView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    let level: GameLevel

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    )

    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                header

                if let question = viewModel.currentQuestion {
                    Map(
                        coordinateRegion: $region,
                        interactionModes: [],
                        annotationItems: [question]
                    ) { item in
                        MapMarker(coordinate: item.coordinate, tint: .red)
                    }
                    .mapStyle(.imagery)
                    .frame(height: 260)
                    .cornerRadius(18)
                    .onAppear {
                        updateRegion(for: question)
                    }
                    .id(question.id)

                    VStack(alignment: .leading, spacing: 16) {
                        Text(question.title)
                            .font(.headline)

                        HStack(spacing: 8) {
                            if viewModel.hasRequestedHint {
                                Image(systemName: "lightbulb.fill")
                                    .foregroundColor(.yellow)
                                Text(viewModel.currentHint ?? "No hint available.")
                                    .fixedSize(horizontal: false, vertical: true)
                            } else {
                                Button {
                                    viewModel.requestHint()
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: "lightbulb")
                                        Text("Show Hint")
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.yellow.opacity(0.8))
                            }
                        }

                        ForEach(question.options.indices, id: \.self) { index in
                            Button {
                                viewModel.submitAnswer(index: index)
                            } label: {
                                let isSelected = viewModel.selectedAnswerIndex == index
                                let borderColor: Color = {
                                    if isSelected {
                                        if let last = viewModel.lastAnswerCorrect {
                                            return last ? .green : .red
                                        } else {
                                            return Color.white.opacity(0.7)
                                        }
                                    } else {
                                        return Color.white.opacity(0.3)
                                    }
                                }()

                                Text(question.options[index])
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white.opacity(0.12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(borderColor, lineWidth: isSelected ? 2 : 1)
                                    )
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.25))
                    .cornerRadius(18)
                } else if viewModel.isGameOver {
                    if viewModel.didCompleteAllQuestions {
                        CongratulationsView(level: level)
                    } else {
                        GameOverView(level: level)
                    }
                } else {
                    ProgressView()
                        .tint(.white)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(level.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel.currentLevel != level || viewModel.currentQuestion == nil {
                viewModel.start(level: level)
            }
        }
        .onReceive(timer) { _ in
            if viewModel.timeRemaining > 0 && !viewModel.isGameOver {
                SoundManager.shared.playTick()
            }
            viewModel.tickTimer()
        }
        .onChange(of: viewModel.isGameOver) { isGameOver in
            if isGameOver {
                timer.upstream.connect().cancel()
                if viewModel.didCompleteAllQuestions {
                    SoundManager.shared.playSuccess()
                } else {
                    SoundManager.shared.playGameOver()
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Text("Score: \(viewModel.score)")
            Spacer()
            Text("Time: \(viewModel.timeRemaining)")
                .monospacedDigit()
        }
        .font(.headline)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.25))
        .cornerRadius(18)
        .foregroundColor(.white)
    }

    private func updateRegion(for question: GeoQuestion) {
        // Use a larger span so the map shows (roughly) the whole country around the town
        region = MKCoordinateRegion(
            center: question.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15)
        )
    }
}

#Preview {
    ContentView()
        .environmentObject(QuizViewModel())
}
