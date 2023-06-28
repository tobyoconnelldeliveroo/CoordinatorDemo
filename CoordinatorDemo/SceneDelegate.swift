import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let coordinator = HomeCoordinator(logger: PrintLogger(), navigationController: navigationController, screenBuilder: HomeScreenBuilder())
        coordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.tintColor = .label
    }
}

