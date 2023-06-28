import UIKit


class GreenCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let screenBuilder: GreenScreenBuilding
    private let showYellow: () -> Void

    init(
        navigationController: UINavigationController?,
        screenBuilder: GreenScreenBuilding,
        showYellow: @escaping () -> Void
    ) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
        self.showYellow = showYellow
    }
    
    func start() {
        let viewModel = GreenViewModel(showYellow: showYellow)
        let screen = screenBuilder.buildGreenScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
}
