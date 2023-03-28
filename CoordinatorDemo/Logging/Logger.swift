protocol Logging {
    func log(_ text: String)
}

struct PrintLogger: Logging {
    func log(_ text: String) {
        print(text)
    }
}
