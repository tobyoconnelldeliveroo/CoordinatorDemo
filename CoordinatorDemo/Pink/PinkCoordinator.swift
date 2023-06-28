import UIKit


class PinkCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let screenBuilder: PinkScreenBuilding
    private let finish: () -> Void
    
    init(navigationController: UINavigationController?, screenBuilder: PinkScreenBuilding, finish: @escaping () -> Void) {
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
        navigationController?.pushViewController(screen, animated: true)
    }
    
    private func showSecondPinkScreen() {
        let viewModel = PinkViewModel(title: "Pink 2", continue: showThirdPinkScreen)
        let screen = screenBuilder.buildPinkScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
    
    private func showThirdPinkScreen() {
        let viewModel = PinkViewModel(title: "Pink 3", continue: finish)
        let screen = screenBuilder.buildPinkScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen, animated: true)
    }
}
