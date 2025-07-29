import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(result: QuizResultsViewModel)
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func stopClickButton(isEnabled: Bool)
    func showNetworkError(message: String)
}

