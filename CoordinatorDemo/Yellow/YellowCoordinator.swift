import UIKit

class YellowCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: YellowScreenBuilding<ViewController>
>: Coordinator {
    private weak var navigationController: NavigationController?
    private let screenBuilder: ScreenBuilder
    private let close: () -> Void
    
    init(navigationController: NavigationController?, screenBuilder: ScreenBuilder, close: @escaping () -> Void) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
        self.close = close
    }
    
    func start() {
        let viewModel = YellowViewModel(close: close)
        let screen = screenBuilder.buildYellowScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen)
    }
}
