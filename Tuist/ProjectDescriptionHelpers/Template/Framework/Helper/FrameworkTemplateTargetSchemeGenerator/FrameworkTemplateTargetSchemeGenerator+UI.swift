import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

extension FrameworkTemplateTargetSchemeGenerator {
    enum UI {}
}

extension Generator.UI {
    struct UIModule {
        let target: Target
        let scheme: Scheme

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = FrameworkTemplate.DefaultValue.deploymentTargets,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = [])
        {
            let bundleId = BundleIdGenerator().generate(name: name)

            target = .target(name: name,
                             destinations: destinations,
                             product: .staticLibrary,
                             productName: name,
                             bundleId: bundleId,
                             deploymentTargets: deploymentTargets,
                             infoPlist: .extendingDefault(with: infoPlist),
                             sources: ["Sources/UI/**"],
                             dependencies: dependencies,
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

    struct UIPreview {
        let target: Target
        let scheme: Scheme

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = FrameworkTemplate.DefaultValue.deploymentTargets,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = [])
        {
            let bundleId = BundleIdGenerator().generate(name: name)

            target = .target(name: name,
                             destinations: destinations,
                             product: .framework,
                             productName: name,
                             bundleId: bundleId,
                             deploymentTargets: deploymentTargets,
                             infoPlist: .extendingDefault(with: infoPlist),
                             sources: ["UIPreview/**"],
                             dependencies: dependencies,
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

    struct UIPreviewApp {
        let target: Target
        let scheme: Scheme

        init(name: String,
             destinations: Destinations = .iOS,
             deploymentTargets: DeploymentTargets = FrameworkTemplate.DefaultValue.deploymentTargets,
             infoPlist: [String: Plist.Value] = [:],
             dependencies: [TargetDependency] = [])
        {
            let bundleId = FrameworkTemplate.DefaultValue.BundleID.uiPreviewApp

            target = .target(name: name,
                             destinations: destinations,
                             product: .app,
                             productName: name,
                             bundleId: bundleId,
                             deploymentTargets: deploymentTargets,
                             infoPlist: .extendingDefault(with: infoPlist),
                             sources: ["App/UIPreviewApp/Sources/**"],
                             resources: ["App/UIPreviewApp/Resources/**"],
                             dependencies: dependencies,
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
