import Foundation

class QuizRepository: ObservableObject {
    static let shared = QuizRepository()
    
    private init() {}
    
    func loadQuestions(for topic: QuizTopic) -> [Question] {
        guard let url = Bundle.main.url(forResource: topic.fileName, withExtension: "json", subdirectory: "questions"),
              let data = try? Data(contentsOf: url),
              let questions = try? JSONDecoder().decode([Question].self, from: data) else {
            print("Failed to load questions for \(topic.fileName)")
            return []
        }
        
        return questions.shuffled()
    }
    
    /// クイズ状態をリセット（選択数・現在の問題番号・採点結果などを初期化）
    func resetAll() {
        // 必要に応じて、クイズの進行状態を管理するプロパティがあればここでリセット
        print("[QuizRepository] All quiz states have been reset")
    }
}