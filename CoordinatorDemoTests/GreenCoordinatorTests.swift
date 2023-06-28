import XCTest
@testable import CoordinatorDemo

final class GreenCoordinatorTests: XCTestCase {
    var navigationController: SpyNavigationController!
    var screenBuilder: MockGreenScreenBuilder!
    var coordinator: GreenCoordinator!
    var logger: MockLogger!
    var showYellow: (() -> Void)!

    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        logger = .init()
        coordinator = .init(
            navigationController: navigationController,
            screenBuilder: screenBuilder,
            logger: logger,
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
    
    func testDismiss_logsDismissal() {
        // Given
        var loggedText: String?
        let mockGreenScreen = UIViewController()
        var greenViewModel: GreenViewModel?
        
        logger.mockLog = { text in
            loggedText = text
        }
        
        navigationController.mockPushViewController = { _, _ in }
        
        screenBuilder.mockBuildGreenScreen = { viewModel in
            greenViewModel = viewModel
            return mockGreenScreen
        }
        
        // When
        coordinator.start()
        greenViewModel?.deinit()
                
        // Then
        XCTAssertEqual(loggedText, "Green screen no longer exists")
    }
}
