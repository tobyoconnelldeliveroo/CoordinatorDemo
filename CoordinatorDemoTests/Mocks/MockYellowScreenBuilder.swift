@testable import CoordinatorDemo

class MockYellowScreenBuilder: YellowScreenBuilding {
    typealias NavigationController = MockNavigationControlling
    typealias ViewController = MockViewControlling
    
    var mockBuildYellowScreen: ((YellowViewModel) -> MockViewControlling)!
    
    func buildYellowScreen(viewModel: YellowViewModel) -> ViewController {
        mockBuildYellowScreen(viewModel)
    }
}
