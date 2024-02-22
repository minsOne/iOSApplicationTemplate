import Foundation

open class AutoModuleScanType {
    public required init() {}
}

public protocol AutoModulable: AnyObject {
    associatedtype ModuleKeyType: InjectionKeyType
}

public typealias AutoModule = AutoModuleScanType & AutoModulable

#if DEBUG
public extension AutoModulable {
    var module: Module? {
        guard
            let instance = self as? ModuleKeyType.Value
        else { return nil }

        return Module(ModuleKeyType.self) { instance }
    }
}
#endif
