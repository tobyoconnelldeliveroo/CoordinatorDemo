import UIKit

protocol HomeScreenBuilding {
    func buildHomeScreen(viewModel: HomeViewModel) -> UIViewController
    func buildGreenCoordinator(navigationController: UINavigationController?)
    func buildYellowCoordinator(logger: Logging, showGreen: @escaping () -> Void, close: @escaping () -> Void) -> UIViewController
    func buildPinkCoordinator(navigationController: UINavigationController?, finish: @escaping () -> Void)
}

struct HomeScreenBuilder: HomeScreenBuilding {
    func buildHomeScreen(viewModel: HomeViewModel) -> UIViewController {
        HomeViewController(viewModel: viewModel)
    }
    
    func buildGreenCoordinator(navigationController: UINavigationController?) {
        GreenCoordinator(
            navigationController: navigationController,
            screenBuilder: GreenScreenBuilder()
        ).start()
    }
    
    func buildYellowCoordinator(logger: Logging, showGreen: @escaping () -> Void, close: @escaping () -> Void) -> UIViewController {
        let navigationController = UINavigationController()
        let coordinator = YellowCoordinator(
            navigationController: navigationController,
            screenBuilder: YellowScreenBuilder(),
            logger: logger,
            showGreen: showGreen,
            close: close
        )
        coordinator.start()
        return navigationController
    }
    
    func buildPinkCoordinator(navigationController: UINavigationController?, finish: @escaping () -> Void) {
        PinkCoordinator(
            navigationController: navigationController,
            screenBuilder: PinkScreenBuilder(),
            finish: finish
        ).start()
    }
}
