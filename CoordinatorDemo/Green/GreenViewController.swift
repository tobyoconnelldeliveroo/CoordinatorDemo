import UIKit

class GreenViewController: UIViewController {
    private let viewModel: GreenViewModel
    
    init(viewModel: GreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Green"
        let content = UILabel.body(text: "This screen is controlled by GreenCoordinator")
        view = BasicView(backgroundColor: .systemGreen, scrollingContent: [content])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        viewModel.didFinish()
    }
}

