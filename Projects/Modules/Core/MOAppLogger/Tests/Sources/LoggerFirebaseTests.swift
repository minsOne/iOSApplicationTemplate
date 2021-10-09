import Foundation
import XCTest
@testable import MOAppLogger

final class LoggerFirebaseTests: XCTestCase {
    var mock: FirebaseAnalyticsServiceMock!

    override func setUp() {
        super.setUp()

        self.mock = FirebaseAnalyticsServiceMock()
        Logger.Firebase.service = mock
    }

    func test_register() {
        Logger.Firebase.register(bundle: .main, plistName: "GoogleService-Info")
        XCTAssertEqual(mock.registerCount, 1)
    }

    func test_logevent() {
        Logger.Firebase.logEvent(event: .appStart)
        XCTAssertEqual(mock.logEventCount, 1)

        Logger.Firebase.logEvent(event: .appStart, attr: [.itemId("")])
        XCTAssertEqual(mock.logEventCount, 2)

        Logger.Firebase.logEvent(event: .appStart, attr: .itemId(""))
        XCTAssertEqual(mock.logEventCount, 3)
    }
}
