@testable import CoordinatorDemo
import UIKit

class MockPinkScreenBuilder: PinkScreenBuilding {
    var mockBuildPinkScreen: ((PinkViewModel) -> UIViewController)!
    
    func buildPinkScreen(viewModel: PinkViewModel) -> UIViewController {
        mockBuildPinkScreen(viewModel)
    }
}
