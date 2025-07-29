import UIKit

final class MovieQuizViewController: UIViewController, AlertDelegate,
    MovieQuizViewControllerProtocol
{

    private var presenter: MovieQuizPresenter!
    private var alertPresenter: AlertPresenter?
    
    @IBOutlet private var questionTitleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    @IBAction private func yesButtonClicked(_ sender: UIButton) {

        presenter.yesButtonClicked(Any.self)
        stopClickButton(isEnabled: false)
    }

    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked(Any.self)
        stopClickButton(isEnabled: false)

    }

    override func viewDidLoad() {

        super.viewDidLoad()

        configFont()
        presenter = MovieQuizPresenter(viewController: self)
        imageView.layer.cornerRadius = 20
        alertPresenter = AlertPresenter(delegate: self)
        clearBorder()

    }

    func present(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        counterLabel.text = step.questionNumber
        textLabel.text = step.question
        clearBorder()
    }

    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor =
            isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor

    }

    func show(result: QuizResultsViewModel) {

        let message = presenter.makeResultsMessage()

        let alert = UIAlertController(
            title: result.title,
            message: message,
            preferredStyle: .alert
        )

        let action = UIAlertAction(title: result.buttonText, style: .default) {
            [weak self] _ in
            guard let self = self else { return }

            self.presenter.restartGame()
        }

        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
    }

    private func configFont() {
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        questionTitleLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        textLabel.font = UIFont(name: "YSDisplay-Bold", size: 23)
        noButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        yesButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
    }

    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

    func showNetworkError(message: String) {
        hideLoadingIndicator()
        let model = AlertModel(
            title: "Что-то пошло не так(",
            message: "Невозможно загрузить данные",
            buttonText: "Попробовать еще раз"
        ) { [weak self] in
            guard let self = self else { return }

            self.presenter.restartGame()

        }
        alertPresenter?.showAlert(model: model)

    }

    func stopClickButton(isEnabled: Bool) {
        noButton.isEnabled = isEnabled
        yesButton.isEnabled = isEnabled
    }

    private func clearBorder() {
        imageView.layer.borderWidth = 0
    }
}
