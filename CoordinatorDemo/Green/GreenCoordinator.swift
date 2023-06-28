import UIKit


class GreenCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let screenBuilder: GreenScreenBuilding
    
    init(navigationController: UINavigationController?, screenBuilder: GreenScreenBuilding) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
    }
    
    func start() {
        let viewModel = GreenViewModel()
        let screen = screenBuilder.buildGreenScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
}
