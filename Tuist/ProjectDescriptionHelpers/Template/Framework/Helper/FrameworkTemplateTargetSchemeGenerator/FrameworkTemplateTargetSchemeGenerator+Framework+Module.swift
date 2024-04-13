import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

extension Generator.Framework {
    struct Module {
        let target: Target
        let scheme: Scheme

        init(name: String,
             macho: MachO,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = [],
             hiddenScheme: Bool = false,
             unitTestsName: String? = nil,
             needResources: Bool) {
            let product: Product
            let resources: ResourceFileElements?
            var testAction: TestAction?

            switch macho {
            case .static:
                product = .staticLibrary
                resources = nil
            case .dynamic:
                product = .framework
                resources = needResources ? ["Resources/Framework/**"] : nil
            }
            if let unitTestsName {
                testAction = .targets(["\(unitTestsName)"],
                                      configuration: .dev,
                                      options: .options(coverage: true))
            }

            let bundleId = BundleIdGenerator().generate(name: name)
            target = Target.target(name: name,
                                   destinations: destinations,
                                   product: product,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Sources/Framework/**"],
                                   resources: resources,
                                   dependencies: dependencies,
                                   settings: .settings())

            scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: hiddenScheme,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: testAction,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))
        }
    }
}
