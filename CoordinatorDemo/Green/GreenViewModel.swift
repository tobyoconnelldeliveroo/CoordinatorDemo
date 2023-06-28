struct GreenViewModel {
    var showYellow: () -> Void
    var `deinit`: () -> Void
}

extension GreenViewModel {
    init(logger: Logging, showYellow: @escaping () -> Void) {
        self.init(
            showYellow: showYellow,
            deinit: {
                logger.log("Green screen no longer exists")
            }
        )
    }
}
