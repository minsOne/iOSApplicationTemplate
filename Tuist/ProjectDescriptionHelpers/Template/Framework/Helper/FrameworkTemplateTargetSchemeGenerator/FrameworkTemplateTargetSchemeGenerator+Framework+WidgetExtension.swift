import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

extension Generator.Framework {
    struct WidgetExtension {
        let target: Target
        let scheme: Scheme

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = [],
             bundleId: String? = nil,
             environmentVariables: [String: EnvironmentVariable] = [:],
             launchArguments: [LaunchArgument] = [])
        {
            let bundleId = bundleId ?? FrameworkTemplate.DefaultValue.BundleID.widgetExtension

            target = .target(name: name,
                             destinations: destinations,
                             product: .appExtension,
                             productName: name,
                             bundleId: bundleId,
                             deploymentTargets: deploymentTargets,
                             infoPlist: .extendingDefault(with: infoPlist),
                             sources: ["App/WidgetExtension/Sources/**"],
                             resources: ["App/WidgetExtension/Resources/**"],
                             dependencies: dependencies,
                             settings: .settings(),
                             environmentVariables: environmentVariables,
                             launchArguments: launchArguments)

            scheme = .scheme(name: name,
                             shared: true,
                             hidden: true,
                             buildAction: .buildAction(targets: ["\(name)"]),
                             runAction: .runAction(configuration: .dev),
                             archiveAction: .archiveAction(configuration: .dev),
                             profileAction: .profileAction(configuration: .dev),
                             analyzeAction: .analyzeAction(configuration: .dev))
        }
    }
}
