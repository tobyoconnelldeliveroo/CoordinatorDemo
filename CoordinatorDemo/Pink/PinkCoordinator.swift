import UIKit


class PinkCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: PinkScreenBuilding<ViewController>
>: Coordinator {
    private weak var navigationController: NavigationController?
    private let screenBuilder: ScreenBuilder
    private let finish: () -> Void
    
    init(navigationController: NavigationController?, screenBuilder: ScreenBuilder, finish: @escaping () -> Void) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
        self.finish = finish
    }
    
    func start() {
        showFirstPinkScreen()
    }
    
    private func showFirstPinkScreen() {
        let viewModel = PinkViewModel(title: "Pink 1", continue: showSecondPinkScreen)
        let screen = screenBuilder.buildPinkScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen)
    }
    
    private func showSecondPinkScreen() {
        let viewModel = PinkViewModel(title: "Pink 2", continue: showThirdPinkScreen)
        let screen = screenBuilder.buildPinkScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen)
    }
    
    private func showThirdPinkScreen() {
        let viewModel = PinkViewModel(title: "Pink 3", continue: finish)
        let screen = screenBuilder.buildPinkScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen)
    }
}
