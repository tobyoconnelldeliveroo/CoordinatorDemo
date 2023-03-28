import XCTest
@testable import CoordinatorDemo

final class HomeCoordinatorTests: XCTestCase {
    var navigationController: MockNavigationControlling!
    var screenBuilder: MockHomeScreenBuilder!
    var coordinator: HomeCoordinator<MockNavigationControlling, MockViewControlling, MockHomeScreenBuilder>!
    var logger: MockLogger!
    
    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        logger = .init()
        coordinator = .init(
            logger: logger,
            navigationController: navigationController,
            screenBuilder: screenBuilder
        )
    }
    
    func testStart_pushesHomeScreen() {
        // Given
        let mockHomeScreen = MockViewControlling()
        var pushedScreen: MockViewControlling?
        var pushWasAnimated: Bool?
        
        navigationController.mockPush = { screen, animated in
            pushedScreen = screen
            pushWasAnimated = animated
        }
        
        screenBuilder.mockBuildHomeScreen = { _ in
            mockHomeScreen
        }
        
        // When
        coordinator.start()
        
        // Then
        XCTAssertEqual(mockHomeScreen, pushedScreen)
        XCTAssertEqual(pushWasAnimated, true)
    }
    
    func testShowGreen_buildsGreenCoordinator() {
        // Given
        let mockHomeScreen = MockViewControlling()
        var homeViewModel: HomeViewModel?
        var didBuildGreenCoordinator: Bool?
        
        navigationController.mockPush = { _, _ in }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildGreenCoordinator = { _ in
            didBuildGreenCoordinator = true
        }
            
        // When
        coordinator.start()
        homeViewModel?.showGreen()
        
        // Then
        XCTAssertEqual(didBuildGreenCoordinator, true)
    }
    
    func testShowYellow_buildsYellowCoordinator() {
        // Given
        let mockHomeScreen = MockViewControlling()
        let mockYellowNavigationController = MockViewControlling()
        var homeViewModel: HomeViewModel?
        var presentedNavigationController: MockViewControlling?
        var presentationWasAnimated: Bool?
        
        navigationController.mockPush = { _, _ in }
        
        mockHomeScreen.mockPresentViewController = { navigationController, animated, _ in
            presentedNavigationController = navigationController
            presentationWasAnimated = animated
        }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildYellowCoordinator = { _, _, _ in
            return mockYellowNavigationController
        }
        
        // When
        coordinator.start()
        homeViewModel?.showYellow()
        
        // Then
        XCTAssertEqual(presentedNavigationController, mockYellowNavigationController)
        XCTAssertEqual(presentationWasAnimated, true)
    }
    
    func testCloseYellowCoordinator_callsDismiss() {
        // Given
        let mockHomeScreen = MockViewControlling()
        let mockYellowNavigationController = MockViewControlling()
        var homeViewModel: HomeViewModel?
        var presentedNavigationController: MockViewControlling?
        var dismissWasAnimated: Bool?
        var closeYellowCoordinator: (() -> Void)?
        
        navigationController.mockPush = { _, _ in }
        
        mockHomeScreen.mockDismiss = { animated, _ in
            dismissWasAnimated = animated
        }
        
        mockHomeScreen.mockPresentViewController = { navigationController, _, _ in
            presentedNavigationController = navigationController
        }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildYellowCoordinator = { _, _, close in
            closeYellowCoordinator = close
            return mockYellowNavigationController
        }
            
        // When
        coordinator.start()
        homeViewModel?.showYellow()
        closeYellowCoordinator?()
        
        // Then
        XCTAssertEqual(presentedNavigationController, mockYellowNavigationController)
        XCTAssertEqual(dismissWasAnimated, true)
    }
    
    func testYellowCoordinatorShowGreen_dismissesYellow() {
        // Given
        let mockHomeScreen = MockViewControlling()
        let mockYellowNavigationController = MockViewControlling()
        var homeViewModel: HomeViewModel?
        var presentedNavigationController: MockViewControlling?
        var dismissWasAnimated: Bool?
        var yellowCoordinatorShowGreen: (() -> Void)?
        
        navigationController.mockPush = { _, _ in }
        
        mockHomeScreen.mockDismiss = { animated, _ in
            dismissWasAnimated = animated
        }
        
        mockHomeScreen.mockPresentViewController = { navigationController, _, _ in
            presentedNavigationController = navigationController
        }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildYellowCoordinator = { _, showGreen, _ in
            yellowCoordinatorShowGreen = showGreen
            return mockYellowNavigationController
        }
            
        // When
        coordinator.start()
        homeViewModel?.showYellow()
        yellowCoordinatorShowGreen?()
        
        // Then
        XCTAssertEqual(presentedNavigationController, mockYellowNavigationController)
        XCTAssertEqual(dismissWasAnimated, true)
    }
    
    func testYellowCoordinatorShowGreen_buildsGreen() {
        // Given
        let mockHomeScreen = MockViewControlling()
        let mockYellowNavigationController = MockViewControlling()
        var homeViewModel: HomeViewModel?
        var yellowCoordinatorShowGreen: (() -> Void)?
        var homeScreenDismissCompletion: (() -> Void)?
        var didBuildGreenCoordinator: Bool?
        
        navigationController.mockPush = { _, _ in }
        
        mockHomeScreen.mockDismiss = { _, completion in
            homeScreenDismissCompletion = completion
        }
        
        mockHomeScreen.mockPresentViewController = { _, _, _ in }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildYellowCoordinator = { _, showGreen, _ in
            yellowCoordinatorShowGreen = showGreen
            return mockYellowNavigationController
        }
        
        screenBuilder.mockBuildGreenCoordinator = { _ in
            didBuildGreenCoordinator = true
        }
            
        // When
        coordinator.start()
        homeViewModel?.showYellow()
        yellowCoordinatorShowGreen?()
        homeScreenDismissCompletion?()
        
        // Then
        XCTAssertEqual(didBuildGreenCoordinator, true)
    }
    
    func testShowPink_buildsPinkCoordinator() {
        // Given
        let mockHomeScreen = MockViewControlling()
        var homeViewModel: HomeViewModel?
        var didBuildPinkCoordinator: Bool?
        
        navigationController.mockPush = { _, _ in }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildPinkCoordinator = { _, _ in
            didBuildPinkCoordinator = true
        }
            
        // When
        coordinator.start()
        homeViewModel?.showPink()
        
        // Then
        XCTAssertEqual(didBuildPinkCoordinator, true)
    }
    
    func testPinkCoordinator_finish_popsToHomeViewController() {
        // Given
        let mockHomeScreen = MockViewControlling()
        var homeViewModel: HomeViewModel?
        var finishPinkCoordinator: (() -> Void)?
        var poppedToViewController: MockViewControlling?
        var popToViewControllerWasAnimated: Bool?

        navigationController.mockPush = { _, _ in }
        
        navigationController.mockPopToViewController = { viewController, animated in
            poppedToViewController = viewController
            popToViewControllerWasAnimated = animated
            return nil
        }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildPinkCoordinator = { _, finish in
            finishPinkCoordinator = finish
        }
            
        // When
        coordinator.start()
        homeViewModel?.showPink()
        finishPinkCoordinator?()
        
        // Then
        XCTAssertEqual(poppedToViewController, mockHomeScreen)
        XCTAssertEqual(popToViewControllerWasAnimated, true)
    }
    
    func textHomeCoordinatorLogger_isPassedToYellowCoordinator() {
        // Given
        let mockHomeScreen = MockViewControlling()
        let mockYellowNavigationController = MockViewControlling()
        var homeViewModel: HomeViewModel?
        var yellowLogger: Logging?
        
        navigationController.mockPush = { _, _ in }
        
        mockHomeScreen.mockPresentViewController = { _, _, _ in }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildYellowCoordinator = { logger, _, _ in
            yellowLogger = logger
            return mockYellowNavigationController
        }
        
        // When
        coordinator.start()
        homeViewModel?.showYellow()
        
        // Then
        XCTAssertEqual(yellowLogger as? MockLogger, logger)
    }
}
