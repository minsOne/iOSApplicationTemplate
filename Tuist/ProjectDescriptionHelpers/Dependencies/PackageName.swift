import Foundation

public struct PackageName: ExpressibleByStringLiteral {
    public let name: String
    
    public init(stringLiteral value: StringLiteralType) {
        name = value
    }
}

public extension PackageName {
    static let Container: Self = "container"
}
