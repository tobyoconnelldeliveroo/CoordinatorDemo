import UIKit

class YellowCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private var close: () -> Void
    
    init(navigationController: UINavigationController?, close: @escaping () -> Void) {
        self.navigationController = navigationController
        self.close = close
    }
    
    func start() {
        let viewModel = YellowViewModel(close: close)
        let viewController = YellowViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
