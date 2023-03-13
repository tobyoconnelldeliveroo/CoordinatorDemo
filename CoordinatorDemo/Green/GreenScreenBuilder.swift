import UIKit

protocol GreenScreenBuilding<ViewController> {
    associatedtype ViewController: ViewControlling
    
    func buildGreenScreen(viewModel: GreenViewModel) -> ViewController
}

struct GreenScreenBuilder: GreenScreenBuilding {
    typealias ViewController = UIViewController
    
    func buildGreenScreen(viewModel: GreenViewModel) -> UIViewController {
        GreenViewController(viewModel: viewModel)
    }
}
