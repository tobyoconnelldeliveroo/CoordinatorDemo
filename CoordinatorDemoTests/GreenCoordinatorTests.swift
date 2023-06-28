import XCTest
@testable import CoordinatorDemo

final class GreenCoordinatorTests: XCTestCase {
    var navigationController: SpyNavigationController!
    var screenBuilder: MockGreenScreenBuilder!
    var coordinator: GreenCoordinator!
    var showYellow: (() -> Void)!

    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        coordinator = .init(
            navigationController: navigationController,
            screenBuilder: screenBuilder,
            showYellow: { [unowned self] in self.showYellow() }
        )
    }
    
    func testStart_pushesGreenScreen() {
        // Given
        let mockGreenScreen = UIViewController()
        var pushedScreen: UIViewController?
        var pushWasAnimated: Bool?
        
        navigationController.mockPushViewController = { viewController, animated in
            pushedScreen = viewController
            pushWasAnimated = animated
        }
        
        screenBuilder.mockBuildGreenScreen = { _ in
            mockGreenScreen
        }
        
        // When
        coordinator.start()
        
        // Then
        XCTAssertEqual(mockGreenScreen, pushedScreen)
        XCTAssertEqual(pushWasAnimated, true)
    }
    
    func testShowYellow_callsCoordinatorShowYellow() {
        // Given
        let mockGreenScreen = UIViewController()
        var greenViewModel: GreenViewModel?
        var didCallShowYellow: Bool?
        
        showYellow = { didCallShowYellow = true }
        
        navigationController.mockPushViewController = { _, _ in }
        
        screenBuilder.mockBuildGreenScreen = { viewModel in
            greenViewModel = viewModel
            return mockGreenScreen
        }
        
        // When
        coordinator.start()
        greenViewModel?.showYellow()
        
        // Then
        XCTAssertEqual(didCallShowYellow, true)

    }
}
