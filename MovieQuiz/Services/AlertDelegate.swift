import UIKit

protocol AlertDelegate: AnyObject {
    func present(alert: UIAlertController)
}

