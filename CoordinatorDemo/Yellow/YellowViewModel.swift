struct YellowViewModel {
    private let coordinator: YellowCoordinating
    
    init(coordinator: YellowCoordinating) {
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator.dismiss()
    }
}
