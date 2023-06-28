import XCTest
@testable import CoordinatorDemo

final class HomeCoordinatorTests: XCTestCase {
    var navigationController: SpyNavigationController!
    var screenBuilder: MockHomeScreenBuilder!
    var coordinator: HomeCoordinator!
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
        let mockHomeScreen = UIViewController()
        var pushedScreen: UIViewController?
        var pushWasAnimated: Bool?
        
        navigationController.mockPushViewController = { screen, animated in
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
        let mockHomeScreen = UIViewController()
        var homeViewModel: HomeViewModel?
        var didBuildGreenCoordinator: Bool?
        
        navigationController.mockPushViewController = { _, _ in }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildGreenCoordinator = { _, _ in
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
        let mockHomeScreen = SpyViewController()
        let mockYellowNavigationController = UIViewController()
        var homeViewModel: HomeViewModel?
        var presentedNavigationController: UIViewController?
        var presentationWasAnimated: Bool?
        
        navigationController.mockPushViewController = { _, _ in }
        
        mockHomeScreen.mockPresent = { navigationController, animated, _ in
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
        let mockHomeScreen = SpyViewController()
        let mockYellowNavigationController = UIViewController()
        var homeViewModel: HomeViewModel?
        var presentedNavigationController: UIViewController?
        var dismissWasAnimated: Bool?
        var closeYellowCoordinator: (() -> Void)?
        
        navigationController.mockPushViewController = { _, _ in }
        
        mockHomeScreen.mockDismiss = { animated, _ in
            dismissWasAnimated = animated
        }
        
        mockHomeScreen.mockPresent = { navigationController, _, _ in
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
        let mockHomeScreen = SpyViewController()
        let mockYellowNavigationController = UIViewController()
        var homeViewModel: HomeViewModel?
        var presentedNavigationController: UIViewController?
        var dismissWasAnimated: Bool?
        var yellowCoordinatorShowGreen: (() -> Void)?
        
        navigationController.mockPushViewController = { _, _ in }
        
        mockHomeScreen.mockDismiss = { animated, _ in
            dismissWasAnimated = animated
        }
        
        mockHomeScreen.mockPresent = { navigationController, _, _ in
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
        let mockHomeScreen = SpyViewController()
        let mockYellowNavigationController = UIViewController()
        var homeViewModel: HomeViewModel?
        var yellowCoordinatorShowGreen: (() -> Void)?
        var homeScreenDismissCompletion: (() -> Void)?
        var didBuildGreenCoordinator: Bool?
        
        navigationController.mockPushViewController = { _, _ in }
        
        mockHomeScreen.mockDismiss = { _, completion in
            homeScreenDismissCompletion = completion
        }
        
        mockHomeScreen.mockPresent = { _, _, _ in }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildYellowCoordinator = { _, showGreen, _ in
            yellowCoordinatorShowGreen = showGreen
            return mockYellowNavigationController
        }
        
        screenBuilder.mockBuildGreenCoordinator = { _, _ in
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
    
    func testGreenCoordinatorShowYellow_buildsYellow() {
        // Given
        let mockHomeScreen = SpyViewController()
        let mockYellowViewController = UIViewController()
        var homeViewModel: HomeViewModel?
        var greenCoordinatorShowYellow: (() -> Void)?
        var homeScreenDismissCompletion: (() -> Void)?
        var didBuildYellowCoordinator: Bool?
        
        navigationController.mockPushViewController = { _, _ in }
        
        mockHomeScreen.mockDismiss = { _, completion in
            homeScreenDismissCompletion = completion
        }
        
        mockHomeScreen.mockPresent = { _, _, _ in }
        
        screenBuilder.mockBuildHomeScreen = { viewModel in
            homeViewModel = viewModel
            return mockHomeScreen
        }
        
        screenBuilder.mockBuildGreenCoordinator = { _, showYellow in
            greenCoordinatorShowYellow = showYellow
        }
                
        screenBuilder.mockBuildYellowCoordinator = { _, _, _ in
            didBuildYellowCoordinator = true
            return mockYellowViewController
        }
            
        // When
        coordinator.start()
        homeViewModel?.showGreen()
        greenCoordinatorShowYellow?()
        homeScreenDismissCompletion?()
        
        // Then
        XCTAssertEqual(didBuildYellowCoordinator, true)
    }
    
    func testShowPink_buildsPinkCoordinator() {
        // Given
        let mockHomeScreen = UIViewController()
        var homeViewModel: HomeViewModel?
        var didBuildPinkCoordinator: Bool?
        
        navigationController.mockPushViewController = { _, _ in }
        
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
        let mockHomeScreen = UIViewController()
        var homeViewModel: HomeViewModel?
        var finishPinkCoordinator: (() -> Void)?
        var poppedToViewController: UIViewController?
        var popToViewControllerWasAnimated: Bool?

        navigationController.mockPushViewController = { _, _ in }
        
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
        let mockHomeScreen = SpyViewController()
        let mockYellowNavigationController = UIViewController()
        var homeViewModel: HomeViewModel?
        var yellowLogger: Logging?
        
        navigationController.mockPushViewController = { _, _ in }
        
        mockHomeScreen.mockPresent = { _, _, _ in }
        
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
