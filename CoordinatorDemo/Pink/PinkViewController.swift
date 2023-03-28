import UIKit

class PinkViewController: UIViewController {
    let viewModel: PinkViewModel
    
    init(viewModel: PinkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = viewModel.title
        let content = UILabel.body(text: "This screen is controlled by PinkCoordinator")
        let continueButton = UIButton.primary(text: "Continue", action: viewModel.continue)
        view = BasicView(backgroundColor: .systemPink, scrollingContent: [content], footerContent: [continueButton])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

