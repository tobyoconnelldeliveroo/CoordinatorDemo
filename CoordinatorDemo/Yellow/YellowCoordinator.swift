import UIKit

protocol YellowCoordinating: AnyObject {
    func dismiss()
}

class YellowCoordinator: Coordinator, YellowCoordinating {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private weak var dismisser: Dismissing?
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?, dismisser: Dismissing?) {
        self.navigationController = navigationController
        self.dismisser = dismisser
    }
    
    func start() {
        let viewModel = YellowViewModel(coordinator: self)
        let viewController = YellowViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        dismisser?.dismiss(animated: true)
    }
}
