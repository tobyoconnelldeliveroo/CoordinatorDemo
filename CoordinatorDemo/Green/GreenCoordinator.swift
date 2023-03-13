import UIKit


class GreenCoordinator<
    NavigationController: AnyObject & NavigationControlling<ViewController>,
    ViewController: AnyObject & ViewControlling<ViewController>,
    ScreenBuilder: GreenScreenBuilding<ViewController>
>: Coordinator {
    private weak var navigationController: NavigationController?
    private let screenBuilder: ScreenBuilder
    
    init(navigationController: NavigationController?, screenBuilder: ScreenBuilder) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
    }
    
    func start() {
        let viewModel = GreenViewModel()
        let screen = screenBuilder.buildGreenScreen(viewModel: viewModel)
        navigationController?.pushViewController(screen)
    }
}
