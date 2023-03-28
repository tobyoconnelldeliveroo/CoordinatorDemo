@testable import CoordinatorDemo

class MockPinkScreenBuilder: PinkScreenBuilding {
    typealias NavigationController = MockNavigationControlling
    typealias ViewController = MockViewControlling
    
    var mockBuildPinkScreen: ((PinkViewModel) -> MockViewControlling)!
    
    func buildPinkScreen(viewModel: PinkViewModel) -> ViewController {
        mockBuildPinkScreen(viewModel)
    }
}
