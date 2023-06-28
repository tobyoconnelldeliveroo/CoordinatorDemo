import UIKit

class HomeCoordinator {
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
        
        let showGreen = {
            self.showGreen(showYellow: { showYellow?() })
        }

        let viewModel = HomeViewModel(
            showGreen: showGreen,
            showYellow: { showYellow?() },
            showPink: { showPink?() }
        )
        
        let viewController = screenBuilder.buildHomeScreen(viewModel: viewModel)
        
        showYellow = { [weak viewController] in
            self.showYellow(on: viewController, showGreen: showGreen)
        }
        
        showPink = { [weak viewController] in
            guard let viewController = viewController else { return }
            self.showPink {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showYellow(on viewController: UIViewController?, showGreen: @escaping () -> Void) {
        let navigationController = screenBuilder.buildYellowCoordinator(
            logger: logger,
            showGreen: { [weak viewController] in
                viewController?.dismiss(animated: true, completion: showGreen)
            },
            close: { [weak viewController] in
                viewController?.dismiss(animated: true)
            }
        )
        viewController?.present(navigationController, animated: true)
    }
    
    private func showGreen(showYellow: @escaping () -> Void) {
        screenBuilder.buildGreenCoordinator(
            navigationController: navigationController,
            logger: logger,
            showYellow: {
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.transitionCoordinator?.animate(alongsideTransition: nil) { _ in
                    showYellow()
                }
            }
        )
    }
    
    private func showPink(finish: @escaping () -> Void) {
        screenBuilder.buildPinkCoordinator(navigationController: navigationController, logger: logger, finish: finish)
    }
}
