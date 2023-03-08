import UIKit

class GreenViewController: UIViewController {
    init(viewModel: GreenViewModel) {
        super.init(nibName: nil, bundle: nil)
        title = "Green"
        let content = UILabel.body(text: "This screen is controlled by GreenCoordinator")
        view = BasicView(backgroundColor: .systemGreen, scrollingContent: [content])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

