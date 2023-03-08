import UIKit

protocol Dismissing: AnyObject {
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension Dismissing {
    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}

extension UIViewController: Dismissing {}
