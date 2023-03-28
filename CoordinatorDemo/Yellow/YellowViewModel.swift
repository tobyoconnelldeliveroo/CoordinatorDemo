struct YellowViewModel {
    var showGreen: () -> Void
    var close: () -> Void
    var `deinit`: () -> Void
}

extension YellowViewModel {
    init(logger: Logging, showGreen: @escaping () -> Void, close: @escaping () -> Void) {
        self.init(
            showGreen: showGreen,
            close: close,
            deinit: {
                logger.log("Yellow screen no longer exists")
            }
        )
    }
}
