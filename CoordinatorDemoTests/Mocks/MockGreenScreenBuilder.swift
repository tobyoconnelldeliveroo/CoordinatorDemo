@testable import CoordinatorDemo
import UIKit

class MockGreenScreenBuilder: GreenScreenBuilding {
    var mockBuildGreenScreen: ((GreenViewModel) -> UIViewController)!
    
    func buildGreenScreen(viewModel: GreenViewModel) -> UIViewController {
        mockBuildGreenScreen(viewModel)
    }
}
