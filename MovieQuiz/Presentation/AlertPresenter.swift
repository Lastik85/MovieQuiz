import Foundation
import UIKit

final class AlertPresenter{
    
    private weak var delegate: AlertDelegate?
    init(delegate: AlertDelegate?) {
        self.delegate = delegate
    }
    
    
    func show(alert model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle:  .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            
        }
        alert.addAction(action)
        delegate?.show(alert: alert)
        
    }
}







