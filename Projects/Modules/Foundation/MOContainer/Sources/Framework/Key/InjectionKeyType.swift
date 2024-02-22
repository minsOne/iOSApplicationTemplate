import Foundation

public protocol InjectionKeyType: AnyObject {
    associatedtype Value
    static var value: Value { get }
    static var weakValue: Value? { get }
}

public extension InjectionKeyType {
    static var value: Value {
        Container.resolve(for: Self.self)
    }
    
    static var weakValue: Value? {
        Container.weakResolve(for: Self.self)
    }
}

/// 직접 사용하지 말것
open class InjectionKeyScanType {
    public init() {}
}

public typealias InjectionKey = InjectionKeyScanType & InjectionKeyType
