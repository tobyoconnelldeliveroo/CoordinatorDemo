import UIKit

protocol PinkScreenBuilding<ViewController> {
    associatedtype ViewController: ViewControlling
    
    func buildPinkScreen(viewModel: PinkViewModel) -> ViewController
}

struct PinkScreenBuilder: PinkScreenBuilding {
    typealias ViewController = UIViewController

    func buildPinkScreen(viewModel: PinkViewModel) -> ViewController {
        PinkViewController(viewModel: viewModel)
    }
}
