import UIKit

protocol YellowScreenBuilding<ViewController> {
    associatedtype ViewController: ViewControlling
    
    func buildYellowScreen(viewModel: YellowViewModel) -> ViewController
}

struct YellowScreenBuilder: YellowScreenBuilding {
    typealias ViewController = UIViewController
    
    func buildYellowScreen(viewModel: YellowViewModel) -> UIViewController {
        YellowViewController(viewModel: viewModel)
    }
}
