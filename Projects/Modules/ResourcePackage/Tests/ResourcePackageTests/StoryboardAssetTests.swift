import XCTest
@testable import ResourcePackage

final class StoryboardAssetTests: XCTestCase {
    func test_storyboard() {
        XCTAssertNotNil(storyboardResourcePath(R.Storyboard.Loan.Completion.ViewController))
    }
}
