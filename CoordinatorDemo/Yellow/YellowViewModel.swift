struct YellowViewModel {
    private weak var coordinator: YellowCoordinating?
    
    init(coordinator: YellowCoordinating) {
        self.coordinator = coordinator
    }
    
    func close() {
        coordinator?.dismiss()
    }
}
