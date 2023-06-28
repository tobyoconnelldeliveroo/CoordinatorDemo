import UIKit

class HomeCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let screenBuilder: HomeScreenBuilding
    private let logger: Logging
    
    init(logger: Logging, navigationController: UINavigationController?, screenBuilder: HomeScreenBuilding) {
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
                self.navigationController?.popToViewController(screen, animated: true)
            }
        }
        
        navigationController?.pushViewController(screen, animated: true)
    }
    
    private func showYellow(on viewController: UIViewController?) {
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
