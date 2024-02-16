import Foundation

@testable import DIContainer

extension InjectionKeyType {
    static var module: Module? {
        Container.root.modules[String(describing: Self.self)]
    }
}
