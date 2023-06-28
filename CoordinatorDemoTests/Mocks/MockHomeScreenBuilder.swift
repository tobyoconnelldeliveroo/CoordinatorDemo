@testable import CoordinatorDemo
import UIKit

class MockHomeScreenBuilder: HomeScreenBuilding {
    var mockBuildHomeScreen: ((HomeViewModel) -> UIViewController)!
    var mockBuildGreenCoordinator: ((UINavigationController?) -> Void)!
    var mockBuildYellowCoordinator: ((Logging, @escaping () -> Void, @escaping () -> Void) -> UIViewController)!
    var mockBuildPinkCoordinator: ((UINavigationController?, @escaping () -> Void) -> Void)!

    func buildHomeScreen(viewModel: HomeViewModel) -> UIViewController {
        mockBuildHomeScreen(viewModel)
    }
    
    func buildGreenCoordinator(navigationController: UINavigationController?) {
        mockBuildGreenCoordinator(navigationController)
    }
    
    func buildYellowCoordinator(logger: Logging, showGreen: @escaping () -> Void, close: @escaping () -> Void) -> UIViewController {
        mockBuildYellowCoordinator(logger, showGreen, close)
    }
    
    func buildPinkCoordinator(navigationController: UINavigationController?, finish: @escaping () -> Void) {
        mockBuildPinkCoordinator(navigationController, finish)
    }
}
