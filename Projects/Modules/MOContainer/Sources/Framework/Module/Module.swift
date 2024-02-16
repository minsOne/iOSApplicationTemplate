import Foundation

/// A type that contributes to the object graph.
public struct Module {
    let name: String
    let resolve: () -> Any

    public init<T: InjectionKeyType, U>(
        _ name: T.Type,
        _ resolve: @escaping () -> U
    ) where T.Value == U {
        self.name = String(describing: name)
        self.resolve = resolve
    }
}
