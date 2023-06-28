import UIKit

class SpyNavigationController: UINavigationController {
    var mockPushViewController: ((UIViewController, Bool) -> Void)!
    var mockPopToViewController: ((UIViewController, Bool) -> [UIViewController]?)!

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        mockPushViewController(viewController, animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        mockPopToViewController(viewController, animated)
    }
}

class SpyViewController: UINavigationController {
    var mockPresent: ((UIViewController, Bool, (() -> Void)?) -> Void)!
    var mockDismiss: ((Bool, (() -> Void)?) -> Void)!

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        mockPresent(viewControllerToPresent, flag, completion)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        mockDismiss(flag, completion)
    }
}
