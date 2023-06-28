struct PinkViewModel {
    var title: String
    var `continue`: () -> Void
    var `deinit`: () -> Void
}

extension PinkViewModel {
    init(title: String, logger: Logging, `continue`: @escaping () -> Void) {
        self.init(
            title: title,
            continue: `continue`,
            deinit: {
                logger.log("Pink screen (\(title)) no longer exists")
            }
        )
    }
}
