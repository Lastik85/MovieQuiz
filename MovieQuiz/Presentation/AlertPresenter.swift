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
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        alert.addAction(action)
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.present(alert: alert)
        }
        
    }
}







