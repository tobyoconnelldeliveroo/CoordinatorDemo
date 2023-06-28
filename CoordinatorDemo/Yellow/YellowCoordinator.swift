import UIKit

class YellowCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let screenBuilder: YellowScreenBuilding
    private let logger: Logging
    private let close: () -> Void
    private let showGreen: () -> Void

    init(
        navigationController: UINavigationController?,
        screenBuilder: YellowScreenBuilding,
        logger: Logging,
        showGreen: @escaping () -> Void,
        close: @escaping () -> Void
    ) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
        self.logger = logger
        self.showGreen = showGreen
        self.close = close
    }
    
    func start() {
        let viewModel = YellowViewModel(logger: logger, showGreen: showGreen, close: close)
        let screen = screenBuilder.buildYellowScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
}
