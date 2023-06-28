@testable import CoordinatorDemo
import UIKit

class MockYellowScreenBuilder: YellowScreenBuilding {
    var mockBuildYellowScreen: ((YellowViewModel) -> UIViewController)!
    
    func buildYellowScreen(viewModel: YellowViewModel) -> UIViewController {
        mockBuildYellowScreen(viewModel)
    }
}
