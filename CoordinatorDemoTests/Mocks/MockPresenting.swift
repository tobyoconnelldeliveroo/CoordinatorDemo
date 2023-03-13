@testable import CoordinatorDemo

class MockViewControlling: ViewControlling, Equatable {
    var mockPresentViewController: ((MockViewControlling, Bool, (() -> Void)?) -> Void)!
    var mockDismiss: ((Bool, (() -> Void)?) -> Void)!
    
    func present(_ viewController: MockViewControlling, animated: Bool, completion: (() -> Void)?) {
        mockPresentViewController(viewController, animated, completion)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        mockDismiss(animated, completion)
    }
    
    static func == (lhs: MockViewControlling, rhs: MockViewControlling) -> Bool {
        lhs === rhs
    }
}
