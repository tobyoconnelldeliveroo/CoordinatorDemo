import UIKit

protocol GreenScreenBuilding {
    func buildGreenScreen(viewModel: GreenViewModel) -> UIViewController
}

struct GreenScreenBuilder: GreenScreenBuilding {
    func buildGreenScreen(viewModel: GreenViewModel) -> UIViewController {
        GreenViewController(viewModel: viewModel)
    }
}
