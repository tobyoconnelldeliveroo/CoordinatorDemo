import UIKit

protocol PinkScreenBuilding {
    func buildPinkScreen(viewModel: PinkViewModel) -> UIViewController
}

struct PinkScreenBuilder: PinkScreenBuilding {
    func buildPinkScreen(viewModel: PinkViewModel) -> UIViewController {
        PinkViewController(viewModel: viewModel)
    }
}
