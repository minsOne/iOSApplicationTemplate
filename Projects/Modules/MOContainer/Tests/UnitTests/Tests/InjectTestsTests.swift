import XCTest

@testable import DIContainer

final class InjectTests: XCTestCase {
    override func setUp() {
        super.setUp()

        Container {
            Module(MockServiceKey.self) { MockServiceImpl() }
        }
        .build()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func test_컨테이너_등록여부_확인_1() {
        XCTAssertNotNil(MockServiceKey.module?.resolve())
        XCTAssertNotNil(MockServiceKey.module?.resolve() as? MockServiceKey.Value)
        XCTAssertNotNil(MockServiceKey.module?.resolve() as? MockService)
    }

    func test_컨테이너_등록여부_확인_2() {
        @Inject(MockServiceKey.self) var service; _ = service
    }

    func test_Inject동작확인_1() {
        @Inject(MockServiceKey.self)
        var service: MockService

        service.doSomething()
        XCTAssertEqual((service as? MockServiceImpl)?.count, 1)
    }

    func test_Inject동작확인_2() {
        @Inject(MockServiceKey.self) var service
        service.doSomething()
        XCTAssertEqual((service as? MockServiceImpl)?.count, 1)
    }
}
