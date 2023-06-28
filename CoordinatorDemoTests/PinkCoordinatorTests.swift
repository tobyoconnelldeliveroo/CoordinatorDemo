import XCTest
@testable import CoordinatorDemo

final class PinkCoordinatorTests: XCTestCase {
    var navigationController: SpyNavigationController!
    var screenBuilder: MockPinkScreenBuilder!
    var coordinator: PinkCoordinator!
    var logger: MockLogger!
    var finish: (() -> Void)!
    
    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        logger = .init()
        coordinator = .init(
            navigationController: navigationController,
            screenBuilder: screenBuilder,
            logger: logger,
            finish: { [unowned self] in self.finish() }
        )
    }
    
    func testStart_pushesFirstPinkScreen() {
        // Given
        let mockPinkScreen = UIViewController()
        var pushedScreen: UIViewController?
        var pushWasAnimated: Bool?
        var pinkViewModel: PinkViewModel?
        
        navigationController.mockPushViewController = { viewController, animated in
            pushedScreen = viewController
            pushWasAnimated = animated
        }
        
        screenBuilder.mockBuildPinkScreen = { viewModel in
            pinkViewModel = viewModel
            return mockPinkScreen
        }
        
        // When
        coordinator.start()
        
        // Then
        XCTAssertEqual(pinkViewModel?.title, "Pink 1")
        XCTAssertEqual(mockPinkScreen, pushedScreen)
        XCTAssertEqual(pushWasAnimated, true)
    }
    
    func testFirstPinkScreenContinue_pushesSecondPinkScreen() {
        // Given
        let mockPinkScreen = UIViewController()
        var pushedScreen: UIViewController?
        var pushWasAnimated: Bool?
        var pinkViewModel: PinkViewModel?
        
        navigationController.mockPushViewController = { viewController, animated in
            pushedScreen = viewController
            pushWasAnimated = animated
        }
        
        screenBuilder.mockBuildPinkScreen = { viewModel in
            pinkViewModel = viewModel
            return mockPinkScreen
        }
        
        // When
        coordinator.start()
        pinkViewModel?.continue()
        
        // Then
        XCTAssertEqual(pinkViewModel?.title, "Pink 2")
        XCTAssertEqual(mockPinkScreen, pushedScreen)
        XCTAssertEqual(pushWasAnimated, true)
    }
    
    func testSecondPinkScreenContinue_pushesThirdPinkScreen() {
        // Given
        let mockPinkScreen = UIViewController()
        var pushedScreen: UIViewController?
        var pushWasAnimated: Bool?
        var pinkViewModel: PinkViewModel?
        
        navigationController.mockPushViewController = { viewController, animated in
            pushedScreen = viewController
            pushWasAnimated = animated
        }
        
        screenBuilder.mockBuildPinkScreen = { viewModel in
            pinkViewModel = viewModel
            return mockPinkScreen
        }
        
        // When
        coordinator.start()
        pinkViewModel?.continue()
        pinkViewModel?.continue()

        // Then
        XCTAssertEqual(pinkViewModel?.title, "Pink 3")
        XCTAssertEqual(mockPinkScreen, pushedScreen)
        XCTAssertEqual(pushWasAnimated, true)
    }
    
    func testThirdPinkScreenContinue_finishesCoordinator() {
        // Given
        let mockPinkScreen = UIViewController()
        var pinkViewModel: PinkViewModel?
        var coordinatorDidComplete: Bool?
        
        navigationController.mockPushViewController = { _, _ in }
        
        screenBuilder.mockBuildPinkScreen = { viewModel in
            pinkViewModel = viewModel
            return mockPinkScreen
        }
        
        finish = {
            coordinatorDidComplete = true
        }
        
        // When
        coordinator.start()
        pinkViewModel?.continue()
        pinkViewModel?.continue()
        pinkViewModel?.continue()

        // Then
        XCTAssertEqual(coordinatorDidComplete, true)
    }
    
    func testFirstDismiss_logsDismissal() {
        // Given
        var loggedText: String?
        let mockPinkScreen = UIViewController()
        var pinkViewModel: PinkViewModel?
        
        logger.mockLog = { text in
            loggedText = text
        }
        
        navigationController.mockPushViewController = { _, _ in }
        
        screenBuilder.mockBuildPinkScreen = { viewModel in
            pinkViewModel = viewModel
            return mockPinkScreen
        }
        
        // When
        coordinator.start()
        pinkViewModel?.deinit()
                
        // Then
        XCTAssertEqual(loggedText, "Pink screen (Pink 1) no longer exists")
    }
    
    func testSecondDismiss_logsDismissal() {
        // Given
        var loggedText: String?
        let mockPinkScreen = UIViewController()
        var pinkViewModel: PinkViewModel?
        
        logger.mockLog = { text in
            loggedText = text
        }
        
        navigationController.mockPushViewController = { _, _ in }
        
        screenBuilder.mockBuildPinkScreen = { viewModel in
            pinkViewModel = viewModel
            return mockPinkScreen
        }
        
        // When
        coordinator.start()
        pinkViewModel?.continue()
        pinkViewModel?.deinit()
                
        // Then
        XCTAssertEqual(loggedText, "Pink screen (Pink 2) no longer exists")
    }
    
    func testThirdDismiss_logsDismissal() {
        // Given
        var loggedText: String?
        let mockPinkScreen = UIViewController()
        var pinkViewModel: PinkViewModel?
        
        logger.mockLog = { text in
            loggedText = text
        }
        
        navigationController.mockPushViewController = { _, _ in }
        
        screenBuilder.mockBuildPinkScreen = { viewModel in
            pinkViewModel = viewModel
            return mockPinkScreen
        }
        
        // When
        coordinator.start()
        pinkViewModel?.continue()
        pinkViewModel?.continue()
        pinkViewModel?.deinit()
                
        // Then
        XCTAssertEqual(loggedText, "Pink screen (Pink 3) no longer exists")
    }
}
