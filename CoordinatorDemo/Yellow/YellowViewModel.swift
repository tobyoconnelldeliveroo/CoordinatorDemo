struct YellowViewModel {
    private weak var coordinator: (Coordinator & YellowCoordinating)?
    
    init(coordinator: Coordinator & YellowCoordinating) {
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator?.dismiss()
    }
    
    func didFinish() {
        coordinator?.didFinish()
    }
}
