import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    let level: GameLevel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Text("Game Over")
                .font(.largeTitle.bold())

            Text("Score: \(viewModel.score)")

            Text("You answered \(viewModel.correctAnswers)/\(viewModel.questionsPerLevel) correctly")

            if let best = viewModel.highScores[level] {
                Text("Best for \(level.title): \(best)")
                    .foregroundColor(.white.opacity(0.8))
            }

            Button("Back to Home") {
                viewModel.navigateHomeRequested = true
                dismiss()
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white.opacity(0.12))
            .cornerRadius(14)
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(22)
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
    }
}
