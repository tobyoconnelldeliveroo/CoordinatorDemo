import UIKit

protocol GreenCoordinating: AnyObject {}

class GreenCoordinator: Coordinator, GreenCoordinating {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GreenViewModel(coordinator: self)
        let viewController = GreenViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
