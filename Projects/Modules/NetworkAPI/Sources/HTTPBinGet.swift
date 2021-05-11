import Foundation
import NetworkAPIKit

#if DEBUG
public struct HTTPBinGet: APIRequestDefinition {
    public let baseURL: String = "https://httpbin.org"
    
    public let method: HTTPMethod = .get
    
    public let path: String = "get"
    
    public var parameter: Parameter = Parameter()
    public init() {}
}

public extension HTTPBinGet {
    struct Parameter: Codable {
        public var aa: String = "bb"
    }
    
    struct Response: Codable {}
}
#endif
