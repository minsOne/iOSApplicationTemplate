import Foundation
import ProjectDescription

public extension Dep.Project.Network {
    static let APIs = Dep.network(name: "NetworkAPIs")
    static let APIKit = Dep.network(name: "NetworkAPIKit")
    static let Common = Dep.network(name: "NetworkAPICommon")
    static let Home = Dep.network(name: "NetworkAPIHome")
    static let Login = Dep.network(name: "NetworkAPILogin")
}
