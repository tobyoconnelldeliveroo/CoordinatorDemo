@testable import CoordinatorDemo

class MockLogger: Logging, Equatable {
    var mockLog: ((String) -> Void)!
    
    func log(_ text: String) {
        mockLog(text)
    }
    
    static func == (lhs: MockLogger, rhs: MockLogger) -> Bool {
        lhs === rhs
    }
}
