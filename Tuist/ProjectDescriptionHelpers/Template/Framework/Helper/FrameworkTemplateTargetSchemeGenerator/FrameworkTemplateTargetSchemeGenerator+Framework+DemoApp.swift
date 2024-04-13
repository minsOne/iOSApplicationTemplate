import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

extension Generator.Framework {
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
}
