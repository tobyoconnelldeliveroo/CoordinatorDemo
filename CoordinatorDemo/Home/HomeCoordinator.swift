import UIKit

class HomeCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: HomeScreenBuilding<NavigationController, ViewController>
>: Coordinator {
    private weak var navigationController: NavigationController?
    private let screenBuilder: ScreenBuilder
    
    init(navigationController: NavigationController?, screenBuilder: ScreenBuilder) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
    }
    
    func start() {
        var showYellow: (() -> Void)?
        let viewModel = HomeViewModel(
            showGreen: showGreen,
            showYellow: { showYellow?() }
        )
        let screen = screenBuilder.buildHomeScreen(viewModel: viewModel)
        showYellow = { [weak screen] in
            self.showYellow(on: screen)
        }
        navigationController?.pushViewController(screen)
    }
    
    private func showYellow(on viewController: ViewController?) {
        let navigationController = screenBuilder.buildYellowCoordinator(
            showGreen: {
                viewController?.dismiss(animated: true, completion: self.showGreen)
            },
            close: { [weak viewController] in
                viewController?.dismiss(animated: true)
            }
        )
        viewController?.present(navigationController, animated: true)
    }
    
    private func showGreen() {
        screenBuilder.buildGreenCoordinator(navigationController: navigationController)
    }
}
