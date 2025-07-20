import Foundation
import UIKit

protocol AlertDelegate: AnyObject {
    func present(alert: UIAlertController)
}

