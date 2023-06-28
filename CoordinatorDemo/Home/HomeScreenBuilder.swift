import UIKit

protocol HomeScreenBuilding {
    func buildHomeScreen(viewModel: HomeViewModel) -> UIViewController
    func buildGreenCoordinator(navigationController: UINavigationController?, logger: Logging, showYellow: @escaping () -> Void)
    func buildYellowCoordinator(logger: Logging, showGreen: @escaping () -> Void, close: @escaping () -> Void) -> UIViewController
    func buildPinkCoordinator(navigationController: UINavigationController?, logger: Logging, finish: @escaping () -> Void)
}

struct HomeScreenBuilder: HomeScreenBuilding {
    func buildHomeScreen(viewModel: HomeViewModel) -> UIViewController {
        HomeViewController(viewModel: viewModel)
    }
    
    func buildGreenCoordinator(navigationController: UINavigationController?, logger: Logging, showYellow: @escaping () -> Void) {
        GreenCoordinator(
            navigationController: navigationController,
            screenBuilder: GreenScreenBuilder(),
            logger: logger,
            showYellow: showYellow
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
    
    func buildPinkCoordinator(navigationController: UINavigationController?, logger: Logging, finish: @escaping () -> Void) {
        PinkCoordinator(
            navigationController: navigationController,
            screenBuilder: PinkScreenBuilder(),
            logger: logger,
            finish: finish
        ).start()
    }
}
