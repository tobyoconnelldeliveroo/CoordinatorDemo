import XCTest
@testable import CoordinatorDemo

final class YellowCoordinatorTests: XCTestCase {
    var navigationController: MockNavigationControlling!
    var screenBuilder: MockYellowScreenBuilder!
    var coordinator: YellowCoordinator<MockNavigationControlling, MockViewControlling, MockYellowScreenBuilder>!
    var logger: MockLogger!
    var showGreen: (() -> Void)!
    var close: (() -> Void)!

    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        logger = .init()
        coordinator = .init(
            navigationController: navigationController,
            screenBuilder: screenBuilder,
            logger: logger,
            showGreen: { [unowned self] in self.showGreen() },
            close: { [unowned self] in self.close() }
        )
    }
    
    func testStart_pushesYellowScreen() {
        // Given
        let mockYellowScreen = MockViewControlling()
        var pushedScreen: MockViewControlling?
        var pushWasAnimated: Bool?
        
        navigationController.mockPush = { viewController, animated in
            pushedScreen = viewController
            pushWasAnimated = animated
        }
        
        screenBuilder.mockBuildYellowScreen = { _ in
            mockYellowScreen
        }
        
        // When
        coordinator.start()
        
        // Then
        XCTAssertEqual(mockYellowScreen, pushedScreen)
        XCTAssertEqual(pushWasAnimated, true)
    }
    
    func testScreenClose_callsCoorinatorClose() {
        // Given
        let mockYellowScreen = MockViewControlling()
        var yellowViewModel: YellowViewModel?
        var didCallClose: Bool?
        
        close = { didCallClose = true }
        
        navigationController.mockPush = { _, _ in }
        
        screenBuilder.mockBuildYellowScreen = { viewModel in
            yellowViewModel = viewModel
            return mockYellowScreen
        }
        
        // When
        coordinator.start()
        yellowViewModel?.close()
        
        // Then
        XCTAssertEqual(didCallClose, true)
    }
    
    func testShowGreen_callsCoordinatorShowGreen() {
        // Given
        let mockYellowScreen = MockViewControlling()
        var yellowViewModel: YellowViewModel?
        var didCallShowGreen: Bool?
        
        showGreen = { didCallShowGreen = true }
        
        navigationController.mockPush = { _, _ in }
        
        screenBuilder.mockBuildYellowScreen = { viewModel in
            yellowViewModel = viewModel
            return mockYellowScreen
        }
        
        // When
        coordinator.start()
        yellowViewModel?.showGreen()
        
        // Then
        XCTAssertEqual(didCallShowGreen, true)
    }
    
    func testDismiss_logsDismissal() {
        // Given
        var loggedText: String?
        let mockYellowScreen = MockViewControlling()
        var yellowViewModel: YellowViewModel?
        
        logger.mockLog = { text in
            loggedText = text
        }
        
        navigationController.mockPush = { _, _ in }
        
        screenBuilder.mockBuildYellowScreen = { viewModel in
            yellowViewModel = viewModel
            return mockYellowScreen
        }
        
        // When
        coordinator.start()
        yellowViewModel?.deinit()
                
        // Then
        XCTAssertEqual(loggedText, "Yellow screen no longer exists")
    }
}
