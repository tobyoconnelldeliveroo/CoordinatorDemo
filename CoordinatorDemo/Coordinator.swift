public protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func store(coordinator: Coordinator)
}

extension Coordinator {
    public func didFinish() {
        guard childCoordinators.isEmpty else { return }
        parentCoordinator?.free(coordinator: self)
    }
    
    public func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }
    
    public func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
