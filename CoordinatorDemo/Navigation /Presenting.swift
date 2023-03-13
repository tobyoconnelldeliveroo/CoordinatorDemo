protocol ViewControlling<ViewController> {
    associatedtype ViewController: ViewControlling

    func present(_ viewController: ViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension ViewControlling {
    func present(_ viewController: ViewController, animated: Bool) {
        present(viewController, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}
