import UIKit


class GreenCoordinator {
    private weak var navigationController: UINavigationController?
    private let screenBuilder: GreenScreenBuilding
    private let logger: Logging
    private let showYellow: () -> Void

    init(
        navigationController: UINavigationController?,
        screenBuilder: GreenScreenBuilding,
        logger: Logging,
        showYellow: @escaping () -> Void
    ) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
        self.logger = logger
        self.showYellow = showYellow
    }
    
    func start() {
        let viewModel = GreenViewModel(logger: logger, showYellow: showYellow)
        let screen = screenBuilder.buildGreenScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
}
