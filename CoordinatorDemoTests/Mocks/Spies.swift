import UIKit

class SpyViewControllerTransitionCoordinator: NSObject, UIViewControllerTransitionCoordinator, UIViewControllerTransitionCoordinatorContext {
    override init() {
        super.init()
    }
    
    func animate(
        alongsideTransition animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?,
        completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil
    ) -> Bool {
        completion?(self)
        return true
    }
    
    func animateAlongsideTransition(
        in view: UIView?,
        animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?,
        completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil
    ) -> Bool {
        false
    }
    
    func notifyWhenInteractionEnds(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {}
    func notifyWhenInteractionChanges(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {}
    var isAnimated: Bool = false
    var presentationStyle: UIModalPresentationStyle = .automatic
    var initiallyInteractive: Bool = false
    var isInterruptible: Bool = false
    var isInteractive: Bool = false
    var isCancelled: Bool = false
    var transitionDuration: TimeInterval = .zero
    var percentComplete: CGFloat = .zero
    var completionVelocity: CGFloat = .zero
    var completionCurve: UIView.AnimationCurve = .easeIn
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? { nil }
    func view(forKey key: UITransitionContextViewKey) -> UIView? { nil }
    var containerView: UIView = UIView()
    var targetTransform: CGAffineTransform = .identity
}

class SpyNavigationController: UINavigationController {
    var mockPushViewController: ((UIViewController, Bool) -> Void)!
    var mockPopToViewController: ((UIViewController, Bool) -> [UIViewController]?)!

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        mockPushViewController(viewController, animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        mockPopToViewController(viewController, animated)
    }
    
    override var transitionCoordinator: UIViewControllerTransitionCoordinator? {
        SpyViewControllerTransitionCoordinator()
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
