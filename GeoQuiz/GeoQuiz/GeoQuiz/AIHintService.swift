import Foundation

// Generates location-specific hints. Currently uses a facts table but can be
// swapped for a real AI-backed implementation later.
struct AIHintService {
    func generateHint(for questionTitle: String, options: [String]) -> String {
        guard let correctAnswer = options.first else {
            return "Try focusing on major world cities you know well."
        }

        let facts: [String: String] = [
            "Paris": "This city is home to the Eiffel Tower alongside the River Seine.",
            "New York": "This city contains the Statue of Liberty in New York Harbor.",
            "Sydney": "This harbor city is famous for its white-sailed Opera House.",
            "London": "This capital city has Big Ben and the Houses of Parliament on the Thames.",
            "Rome": "This city is known for the Colosseum and ancient Roman ruins.",
            "Cairo": "This city lies near the pyramids of Giza and the Sphinx.",
            "Beijing": "This capital city is near the Great Wall and Tiananmen Square.",
            "Moscow": "This city features the colorful domes of Saint Basil's Cathedral near Red Square.",
            "Rio de Janeiro": "This city has Christ the Redeemer overlooking a famous bay.",
            "Tokyo": "This mega city mixes neon skyscrapers with traditional temples and Mount Fuji views.",
            "San Francisco": "This coastal city is known for the Golden Gate Bridge and steep hills.",
            "Toronto": "This Canadian city features the CN Tower by Lake Ontario.",
            "Cape Town": "This city sits below Table Mountain on the southern tip of Africa.",
            "Singapore": "This city-state is famous for Marina Bay Sands and a busy harbor.",
            "Dubai": "This desert city is known for the Burj Khalifa, the tallest building in the world.",
            "Hong Kong": "This city has a dense skyline around Victoria Harbour.",
            "Mexico City": "This high-altitude capital sits in a valley surrounded by mountains.",
            "Bangkok": "This city is known for ornate temples and the Chao Phraya River.",
            "Barcelona": "This Spanish city has Gaudí architecture like the Sagrada Família.",
            "Istanbul": "This city spans two continents, Europe and Asia, across the Bosporus.",
            "Machu Picchu": "This site is an ancient Incan citadel high in the Andes.",
            "Giza Pyramids": "These pyramids stand on the west bank of the Nile near Cairo.",
            "Petra": "This ancient city in Jordan is carved into rose-red cliffs.",
            "Angkor Wat": "This huge temple complex lies in the jungles of Cambodia.",
            "Serengeti": "This national park is famous for the great wildebeest migration.",
            "Banff": "This mountain town is surrounded by turquoise lakes in the Canadian Rockies.",
            "Santorini": "This Greek island has white houses with blue domes above the Aegean Sea.",
            "Hallstatt": "This village lies between a lake and steep mountains in Austria.",
            "Bora Bora": "This island is surrounded by a turquoise lagoon and overwater bungalows."
        ]

        if let fact = facts[correctAnswer] {
            return fact
        }

        let firstLetter = correctAnswer.first.map { String($0) } ?? "?"
        return "The correct answer starts with the letter \(firstLetter)."
    }
}
