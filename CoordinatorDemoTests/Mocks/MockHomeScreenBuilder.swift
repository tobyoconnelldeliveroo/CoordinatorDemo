@testable import CoordinatorDemo

class MockHomeScreenBuilder: HomeScreenBuilding {
    typealias NavigationController = MockNavigationControlling
    typealias ViewController = MockViewControlling
    
    var mockBuildHomeScreen: ((HomeViewModel) -> MockViewControlling)!
    var mockBuildGreenCoordinator: ((MockNavigationControlling?) -> Void)!
    var mockBuildYellowCoordinator: ((@escaping () -> Void, @escaping () -> Void) -> MockViewControlling)!

    func buildHomeScreen(viewModel: HomeViewModel) -> MockViewControlling {
        mockBuildHomeScreen(viewModel)
    }
    
    func buildGreenCoordinator(navigationController: MockNavigationControlling?) {
        mockBuildGreenCoordinator(navigationController)
    }
    
    func buildYellowCoordinator(showGreen: @escaping () -> Void, close: @escaping () -> Void) -> MockViewControlling {
        mockBuildYellowCoordinator(showGreen, close)
    }
}
