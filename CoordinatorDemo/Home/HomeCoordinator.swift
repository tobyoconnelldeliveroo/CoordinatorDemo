import UIKit

class HomeCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: HomeScreenBuilding<NavigationController, ViewController>
>: Coordinator {
    private weak var navigationController: NavigationController?
    private let screenBuilder: ScreenBuilder
    private let logger: Logging
    
    init(logger: Logging, navigationController: NavigationController?, screenBuilder: ScreenBuilder) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
        self.logger = logger
    }
    
    func start() {
        var showYellow: (() -> Void)?
        var showPink: (() -> Void)?

        let viewModel = HomeViewModel(
            showGreen: showGreen,
            showYellow: { showYellow?() },
            showPink: { showPink?() }
        )
        
        let screen = screenBuilder.buildHomeScreen(viewModel: viewModel)
        
        showYellow = { [weak screen] in
            self.showYellow(on: screen)
        }
        
        showPink = { [weak screen] in
            guard let screen = screen else { return }
            self.showPink {
                self.navigationController?.popToViewController(screen)
            }
        }
        
        navigationController?.pushViewController(screen)
    }
    
    private func showYellow(on viewController: ViewController?) {
        let navigationController = screenBuilder.buildYellowCoordinator(
            logger: logger,
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
    
    private func showPink(finish: @escaping () -> Void) {
        screenBuilder.buildPinkCoordinator(navigationController: navigationController, finish: finish)
    }
}
