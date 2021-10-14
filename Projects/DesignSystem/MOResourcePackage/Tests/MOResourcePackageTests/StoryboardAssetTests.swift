import XCTest
@testable import MOResourcePackage

final class StoryboardAssetTests: XCTestCase {
    func test_storyboard() {
        XCTAssertNotNil(storyboardResourcePath(R.Storyboard.Loan.Completion.ViewController))
    }
}
