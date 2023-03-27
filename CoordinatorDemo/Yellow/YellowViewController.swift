import UIKit

class YellowViewController: UIViewController {
    let viewModel: YellowViewModel
    
    init(viewModel: YellowViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Yellow"
        let content = UILabel.body(text: "This screen is controlled by YellowCoordinator")
        let showGreenButton = UIButton.primary(text: "Show Green", action: viewModel.showGreen)
        view = BasicView(backgroundColor: .systemYellow, scrollingContent: [content], footerContent: [showGreenButton])
        navigationItem.rightBarButtonItem = .init(systemItem: .close, primaryAction: .init { _ in viewModel.close() })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

