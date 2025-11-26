import SwiftUI

struct HighScoresView: View {
    @EnvironmentObject var viewModel: QuizViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(GameLevel.allCases) { level in
                        HStack(spacing: 16) {
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 24))
                                .frame(width: 44, height: 44)
                                .foregroundColor(.yellow)
                                .background(Color.black.opacity(0.35))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(level.title)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text("Best score")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.75))
                            }

                            Spacer()

                            Text("\(viewModel.highScores[level] ?? 0)")
                                .font(.title3.bold())
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }
                }
                .padding()
            }
        }
        .navigationTitle("High Scores")
    }
}
