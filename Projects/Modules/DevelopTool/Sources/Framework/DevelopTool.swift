import OHHTTPStubsSwift
import OHHTTPStubs

public struct HTTPStubs {
    public static func setup() {
        OHHTTPStubs.HTTPStubs.setEnabled(true)
    }
    /// 1. URL와 Response에 특정 문자열만 String을 내려주는 Stub
    public static func stub(url: String, data str: String) {
        OHHTTPStubsSwift.stub(condition: { (request) -> Bool in
            return (request.url?.absoluteString == url)
        }) { (request) -> HTTPStubsResponse in
            let stubData = str.data(using: .utf8)
            return HTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
        }
    }
    
    /// 2. URL과 Bundle에 있는 파일 내용을 Response로 내려주는 Stub
    public static func stub(url: String, bundle: Bundle, name: String, extension fileExtension: String) {
        guard
            let filePath = bundle.url(forResource: name, withExtension: fileExtension),
            let stubData = try? Data(contentsOf: filePath)
        else { return }
        
        OHHTTPStubsSwift.stub(condition: { (request) -> Bool in
            return (request.url?.absoluteString == url)
        }) { (request) -> HTTPStubsResponse in
            return HTTPStubsResponse(data: stubData, statusCode:200, headers:nil)
        }
    }
    
    /// 3. URL와 임의의 경로에 있는 파일 내용을 Response로 내려주는 Stub
    public static func stub(url: String, path: String) {
        guard
            case let filePath = URL(fileURLWithPath: path),
            let stubData = try? Data(contentsOf: filePath)
        else { return }
        
        OHHTTPStubsSwift.stub(condition: { (request) -> Bool in
            return (request.url?.absoluteString == url)
        }) { (request) -> HTTPStubsResponse in
            return HTTPStubsResponse(data: stubData, statusCode:200, headers:nil)
        }
    }
}
