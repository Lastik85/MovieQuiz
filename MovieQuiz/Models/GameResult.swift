import Foundation


struct GameResult {
    let correct: Int
    let total: Int
    let date: Date
    
    
    func bestGameResult(_ gameResult: GameResult) -> Bool {
        correct > gameResult.correct
        
    }
}
