@testable import CoordinatorDemo

class MockGreenScreenBuilder: GreenScreenBuilding {
    typealias NavigationController = MockNavigationControlling
    typealias ViewController = MockViewControlling
    
    var mockBuildGreenScreen: ((GreenViewModel) -> MockViewControlling)!
    
    func buildGreenScreen(viewModel: GreenViewModel) -> ViewController {
        mockBuildGreenScreen(viewModel)
    }
}
