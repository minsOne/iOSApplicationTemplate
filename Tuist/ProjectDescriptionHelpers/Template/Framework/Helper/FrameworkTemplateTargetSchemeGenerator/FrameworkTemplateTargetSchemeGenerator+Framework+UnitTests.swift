import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

extension Generator.Framework {
    struct UnitTests {
        let target: Target

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = .default,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = [])
        {
            let bundleId = BundleIdGenerator().generate(name: name)

            target = .target(name: name,
                             destinations: destinations,
                             product: .unitTests,
                             productName: name,
                             bundleId: bundleId,
                             deploymentTargets: deploymentTargets,
                             infoPlist: .default,
                             sources: ["Tests/UnitTests/**"],
                             dependencies: dependencies,
                             settings: .settings())
        }
    }
}
