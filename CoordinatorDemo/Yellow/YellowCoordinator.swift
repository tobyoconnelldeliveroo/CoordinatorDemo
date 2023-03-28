import UIKit

class YellowCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: YellowScreenBuilding<ViewController>
>: Coordinator {
    private weak var navigationController: NavigationController?
    private let screenBuilder: ScreenBuilder
    private let logger: Logging
    private let close: () -> Void
    private let showGreen: () -> Void

    init(
        navigationController: NavigationController?,
        screenBuilder: ScreenBuilder,
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
        navigationController?.pushViewController(screen)
    }
}
