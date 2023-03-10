import UIKit

class GreenCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GreenViewModel()
        let viewController = GreenViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
