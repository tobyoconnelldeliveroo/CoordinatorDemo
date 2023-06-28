import XCTest
@testable import CoordinatorDemo

final class GreenCoordinatorTests: XCTestCase {
    var navigationController: SpyNavigationController!
    var screenBuilder: MockGreenScreenBuilder!
    var coordinator: GreenCoordinator!
    var close: (() -> Void)!
    
    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        coordinator = .init(
            navigationController: navigationController,
            screenBuilder: screenBuilder
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
}
