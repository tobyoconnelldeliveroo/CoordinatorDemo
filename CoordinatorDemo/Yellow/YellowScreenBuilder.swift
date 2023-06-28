import UIKit

protocol YellowScreenBuilding {
    func buildYellowScreen(viewModel: YellowViewModel) -> UIViewController
}

struct YellowScreenBuilder: YellowScreenBuilding {
    func buildYellowScreen(viewModel: YellowViewModel) -> UIViewController {
        YellowViewController(viewModel: viewModel)
    }
}
