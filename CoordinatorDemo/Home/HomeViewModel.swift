import UIKit

struct HomeViewModel {
    private weak var coordinator: HomeCoordinating?
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
    
    func showYellow(on viewController: UIViewController?) {
        coordinator?.showYellow(on: viewController)
    }
    
    func showGreen() {
        coordinator?.showGreen()
    }
}
