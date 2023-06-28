import UIKit


class PinkCoordinator {
    private weak var navigationController: UINavigationController?
    private let screenBuilder: PinkScreenBuilding
    private let logger: Logging
    private let finish: () -> Void
    
    init(
        navigationController: UINavigationController?,
        screenBuilder: PinkScreenBuilding,
        logger: Logging,
        finish: @escaping () -> Void
    ) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
        self.logger = logger
        self.finish = finish
    }
    
    func start() {
        showFirstPinkScreen()
    }
    
    private func showFirstPinkScreen() {
        let viewModel = PinkViewModel(title: "Pink 1", logger: logger, continue: showSecondPinkScreen)
        let screen = screenBuilder.buildPinkScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
    
    private func showSecondPinkScreen() {
        let viewModel = PinkViewModel(title: "Pink 2", logger: logger, continue: showThirdPinkScreen)
        let screen = screenBuilder.buildPinkScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
    
    private func showThirdPinkScreen() {
        let viewModel = PinkViewModel(title: "Pink 3", logger: logger, continue: finish)
        let screen = screenBuilder.buildPinkScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
}
