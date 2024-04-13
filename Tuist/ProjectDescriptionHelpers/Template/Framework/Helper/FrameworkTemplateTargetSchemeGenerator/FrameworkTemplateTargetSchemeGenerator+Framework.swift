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
             unitTestsName: String? = nil) {
            let product: Product
            let resources: ResourceFileElements?
            var testAction: TestAction?

            switch macho {
            case .static:
                product = .staticLibrary
                resources = nil
            case .dynamic:
                product = .framework
                resources = nil
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

    struct Testing {
        let target: Target
        let scheme: Scheme

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = []) {
            let bundleId = BundleIdGenerator().generate(name: name)

            target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Testing/**"],
                                   dependencies: dependencies,
                                   settings: .settings())

            scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))
        }
    }

    struct DemoApp {
        let target: Target
        let scheme: Scheme

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = [],
             bundleId: String? = nil,
             environmentVariables: [String: EnvironmentVariable] = [:],
             launchArguments: [LaunchArgument] = [],
             unitTestName: String? = nil) {
            let bundleId = bundleId ?? BundleIdGenerator().defaultDemoAppBundleId
            var testAction: TestAction?
            if let unitTestName {
                testAction = .targets(["\(unitTestName)"],
                                      configuration: .dev,
                                      options: .options(coverage: true))
            }

            target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .app,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["App/DemoApp/Sources/**"],
                                   resources: ["App/DemoApp/Resources/**"],
                                   dependencies: dependencies,
                                   settings: .settings(),
                                   environmentVariables: environmentVariables,
                                   launchArguments: launchArguments)

            scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: testAction,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))
        }
    }

    struct UnitTests {
        let target: Target

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = []) {
            let bundleId = BundleIdGenerator().generate(name: name)

            target = Target.target(name: name,
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
