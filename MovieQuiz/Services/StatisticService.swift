import UIKit

final class StatisticService: StatisticServiceProtocol {
    
    private enum Keys: String {
        case gamesCount
        case bestGamecorrect
        case bestGametotal
        case bestGameDate
        case correctAnswers
    }
    
    private let questionsAmount: Int = 10
    private let storage: UserDefaults = .standard
    
    var gamesCount: Int {
        get{
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult{
        get {
            let correct = storage.integer(forKey: Keys.bestGamecorrect.rawValue)
            let total = storage.integer(forKey: Keys.bestGametotal.rawValue)
            let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
            
        }
        set {
            storage.set(newValue.correct, forKey: Keys.bestGamecorrect.rawValue)
            storage.set(newValue.total, forKey: Keys.bestGametotal.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
            
        }
    }
    
    private var correctAnswers: Int {
        get {
            storage.integer(forKey: Keys.correctAnswers.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.correctAnswers.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        guard gamesCount != 0 else {
            return 0
        }
        return (Double(correctAnswers) / (Double(questionsAmount) * Double(gamesCount))) * 100
    }
    
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        correctAnswers += count
        let nextGame = GameResult(correct: count, total: amount, date: Date())
        if nextGame.bestGameResult(bestGame) {
            bestGame = nextGame
        }
        storage.set(correctAnswers, forKey: Keys.correctAnswers.rawValue)
    }
    
    
    
}


