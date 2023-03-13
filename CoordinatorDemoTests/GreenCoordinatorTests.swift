import XCTest
@testable import CoordinatorDemo

final class GreenCoordinatorTests: XCTestCase {
    var navigationController: MockNavigationControlling!
    var screenBuilder: MockGreenScreenBuilder!
    var coordinator: GreenCoordinator<MockNavigationControlling, MockViewControlling, MockGreenScreenBuilder>!
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
        let mockGreenScreen = MockViewControlling()
        var pushedScreen: MockViewControlling?
        var pushWasAnimated: Bool?
        
        navigationController.mockPush = { viewController, animated in
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
