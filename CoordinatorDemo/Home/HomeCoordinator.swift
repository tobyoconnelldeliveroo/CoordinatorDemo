import UIKit

class HomeCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        var showYellow: (() -> Void)?
        let viewModel = HomeViewModel(
            showGreen: showGreen,
            showYellow: { showYellow?() }
        )
        let viewController = HomeViewController(viewModel: viewModel)
        showYellow = { [weak viewController] in
            self.showYellow(on: viewController)
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showYellow(on viewController: UIViewController?) {
        let yellowNavigationController = UINavigationController()
        let coordinator = YellowCoordinator(
            navigationController: yellowNavigationController,
            close: { [weak viewController] in
                viewController?.dismiss(animated: true)
            }
        )
        coordinator.start()
        viewController?.present(yellowNavigationController, animated: true)
    }
    
    private func showGreen() {
        let coordinator = GreenCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
