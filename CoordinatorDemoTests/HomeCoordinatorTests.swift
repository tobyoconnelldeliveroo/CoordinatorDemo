import XCTest
@testable import CoordinatorDemo

final class HomeCoordinatorTests: XCTestCase {
    var navigationController: MockNavigationControlling!
    var screenBuilder: MockHomeScreenBuilder!
    var coordinator: HomeCoordinator<MockNavigationControlling, MockViewControlling, MockHomeScreenBuilder>!
    
    override func setUp() {
        navigationController = .init()
        screenBuilder = .init()
        coordinator = .init(
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
        
        screenBuilder.mockBuildYellowCoordinator = { _, _ in
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
        
        screenBuilder.mockBuildYellowCoordinator = { _, close in
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
        
        screenBuilder.mockBuildYellowCoordinator = { showGreen, _ in
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
        
        screenBuilder.mockBuildYellowCoordinator = { showGreen, _ in
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
}
