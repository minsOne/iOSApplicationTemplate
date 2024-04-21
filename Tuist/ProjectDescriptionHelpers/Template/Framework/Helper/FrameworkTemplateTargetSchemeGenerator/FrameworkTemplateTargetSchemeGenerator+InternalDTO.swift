import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

extension Generator {
    struct InternalDTO {
        let target: Target
        let scheme: Scheme

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = FrameworkTemplate.DefaultValue.deploymentTargets,
             dependencies: [TargetDependency] = [])
        {
            let bundleId = BundleIdGenerator().generate(name: name)

            target = .target(name: name,
                             destinations: destinations,
                             product: .staticLibrary,
                             productName: name,
                             bundleId: bundleId,
                             deploymentTargets: deploymentTargets,
                             infoPlist: .default,
                             sources: ["Sources/InternalDTO/**"],
                             settings: .settings())
            scheme = .scheme(name: name,
                             shared: true,
                             hidden: true,
                             buildAction: .buildAction(targets: ["\(name)"]),
                             testAction: nil,
                             runAction: .runAction(configuration: .dev),
                             archiveAction: .archiveAction(configuration: .dev),
                             profileAction: .profileAction(configuration: .dev),
                             analyzeAction: .analyzeAction(configuration: .dev))
        }
    }
}
