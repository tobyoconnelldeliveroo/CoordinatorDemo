struct GreenViewModel {
    private weak var coordinator: (Coordinator & GreenCoordinating)?
    
    init(coordinator: Coordinator & GreenCoordinating) {
        self.coordinator = coordinator
    }
    
    func didFinish() {
        coordinator?.didFinish()
    }
}
