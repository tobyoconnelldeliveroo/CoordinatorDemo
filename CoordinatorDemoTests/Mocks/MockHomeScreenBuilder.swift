@testable import CoordinatorDemo

class MockHomeScreenBuilder: HomeScreenBuilding {
    typealias NavigationController = MockNavigationControlling
    typealias ViewController = MockViewControlling
    
    var mockBuildHomeScreen: ((HomeViewModel) -> MockViewControlling)!
    var mockBuildGreenCoordinator: ((MockNavigationControlling?) -> Void)!
    var mockBuildYellowCoordinator: ((Logging, @escaping () -> Void, @escaping () -> Void) -> MockViewControlling)!
    var mockBuildPinkCoordinator: ((MockNavigationControlling?, @escaping () -> Void) -> Void)!

    func buildHomeScreen(viewModel: HomeViewModel) -> MockViewControlling {
        mockBuildHomeScreen(viewModel)
    }
    
    func buildGreenCoordinator(navigationController: MockNavigationControlling?) {
        mockBuildGreenCoordinator(navigationController)
    }
    
    func buildYellowCoordinator(logger: Logging, showGreen: @escaping () -> Void, close: @escaping () -> Void) -> MockViewControlling {
        mockBuildYellowCoordinator(logger, showGreen, close)
    }
    
    func buildPinkCoordinator(navigationController: MockNavigationControlling?, finish: @escaping () -> Void) {
        mockBuildPinkCoordinator(navigationController, finish)
    }
}
