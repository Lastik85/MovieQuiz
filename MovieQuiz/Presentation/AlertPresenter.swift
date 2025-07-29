import UIKit

final class AlertPresenter: AlertProtocol{

    private weak var delegate: AlertDelegate?
    
    init(delegate: AlertDelegate?) {
        self.delegate = delegate
    }
    
    func showAlert(model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle:  .alert)
            alert.view?.accessibilityIdentifier = "Game results"
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        alert.addAction(action)
        delegate?.present(alert: alert)
        
    }
}







