import UIKit

protocol HomeScreenBuilding<NavigationController, ViewController> {
    associatedtype NavigationController: NavigationControlling
    associatedtype ViewController: ViewControlling
    
    func buildHomeScreen(viewModel: HomeViewModel) -> ViewController
    func buildGreenCoordinator(navigationController: NavigationController?)
    func buildYellowCoordinator(showGreen: @escaping () -> Void, close: @escaping () -> Void) -> ViewController
    func buildPinkCoordinator(navigationController: NavigationController?, finish: @escaping () -> Void)
}

struct HomeScreenBuilder: HomeScreenBuilding {
    typealias NavigationController = UINavigationController
    typealias ViewController = UIViewController
    
    func buildHomeScreen(viewModel: HomeViewModel) -> UIViewController {
        HomeViewController(viewModel: viewModel)
    }
    
    func buildGreenCoordinator(navigationController: UINavigationController?) {
        GreenCoordinator(
            navigationController: navigationController,
            screenBuilder: GreenScreenBuilder()
        ).start()
    }
    
    func buildYellowCoordinator(showGreen: @escaping () -> Void, close: @escaping () -> Void) -> ViewController {
        let navigationController = UINavigationController()
        let coordinator = YellowCoordinator(
            navigationController: navigationController,
            screenBuilder: YellowScreenBuilder(),
            showGreen: showGreen,
            close: close
        )
        coordinator.start()
        return navigationController
    }
    
    func buildPinkCoordinator(navigationController: NavigationController?, finish: @escaping () -> Void) {
        PinkCoordinator(
            navigationController: navigationController,
            screenBuilder: PinkScreenBuilder(),
            finish: finish
        ).start()
    }
}
