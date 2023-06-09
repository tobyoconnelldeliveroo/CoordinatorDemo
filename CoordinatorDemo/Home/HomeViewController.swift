import UIKit

class HomeViewController: UIViewController {
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        title = "Home"
        let content = UILabel.body(text: "This screen is controlled by HomeCoordinator")
        let showGreenButton = UIButton.primary(text: "Show Green", action: viewModel.showGreen)
        let showYellowButton = UIButton.primary(text: "Show Yellow", action: viewModel.showYellow)
        let showPinkButton = UIButton.primary(text: "Show Pink", action: viewModel.showPink)
        view = BasicView(backgroundColor: .systemBackground, scrollingContent: content, footerContent: showGreenButton, showYellowButton, showPinkButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

