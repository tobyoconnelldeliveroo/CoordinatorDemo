@testable import CoordinatorDemo

class MockNavigationControlling: NavigationControlling, Equatable {
    var mockPush: ((MockViewControlling, Bool) -> Void)!
    var mockPopToViewController: ((MockViewControlling, Bool) -> [MockViewControlling]?)!
    var mockPopViewController: ((Bool) -> MockViewControlling?)!
    var mockPopToRootViewController: ((Bool) -> [MockViewControlling]?)!
    var mockSetViewControllers: (([MockViewControlling], Bool) -> Void)!
    var mockViewControllers: [MockViewControlling]!
    var mockPresentViewController: ((MockViewControlling, Bool, (() -> Void)?) -> Void)!
    var mockDismiss: ((Bool, (() -> Void)?) -> Void)!
    
    var viewControllers: [MockViewControlling] {
        mockViewControllers
    }

    func pushViewController(_ viewController: MockViewControlling, animated: Bool) {
        mockPush(viewController, animated)
    }
    
    @discardableResult
    func popViewController(animated: Bool) -> MockViewControlling? {
        mockPopViewController(animated)
    }
    
    @discardableResult
    func popToRootViewController(animated: Bool) -> [MockViewControlling]? {
        mockPopToRootViewController(animated)
    }
    
    @discardableResult
    func popToViewController(_ viewController: MockViewControlling, animated: Bool) -> [MockViewControlling]? {
        mockPopToViewController(viewController, animated)
    }
    
    func setViewControllers(_ viewControllers: [MockViewControlling], animated: Bool) {
        mockSetViewControllers(viewControllers, animated)
    }
    
    func present(_ viewController: MockViewControlling, animated: Bool, completion: (() -> Void)?) {
        mockPresentViewController(viewController, animated, completion)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        mockDismiss(animated, completion)
    }
    
    static func == (lhs: MockNavigationControlling, rhs: MockNavigationControlling) -> Bool {
        lhs === rhs
    }
}
