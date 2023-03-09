import UIKit

protocol HomeCoordinating: AnyObject {
    func showYellow(on viewController: UIViewController?)
    func showGreen()
}

class HomeCoordinator: Coordinator, HomeCoordinating {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showYellow(on viewController: UIViewController?) {
        let yellowNavigationController = UINavigationController()
        let coordinator = YellowCoordinator(navigationController: yellowNavigationController, dismisser: viewController)
        coordinator.start()
        viewController?.present(yellowNavigationController, animated: true)
    }
    
    func showGreen() {
        let coordinator = GreenCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
