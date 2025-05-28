//
//  MultipleTargetTemplateGenerator.swift
//  Manifests
//
//  Created by minsOne on 5/23/25.
//

import ProjectDescription

public struct MultipleTargetTemplate {
    public let project: Project
}

public extension MultipleTargetTemplate {
    struct TargetConfigurationInfo {
        let name: String
        let folderName: String
        let dependencies: [TargetDependency]

        public init(
            name: String,
            folderName: String? = nil,
            dependencies: [TargetDependency] = []
        ) {
            self.name = name
            self.folderName = folderName ?? name
            self.dependencies = dependencies
        }
    }

    struct ProjectOption {
        let packageName: String?

        public init(packageName: PackageName? = nil) {
            self.packageName = packageName?.name
        }
    }
}

public extension MultipleTargetTemplate {
    init(name: String,
         organizationName: String = "minsone",
         packages: [Package] = [],
         platform: Platform = .iOS,
         deploymentTarget: DeploymentTargets? = .default,
         target: [Target] = [],
         targetConfigurations: [TargetConfigurationInfo],
         projectOption: ProjectOption? = nil)
    {
        var targets: [ProjectDescription.Target] = []
        var schemes: [Scheme] = []

        var baseSettings: SettingsDictionary = [
            "CODE_SIGN_IDENTITY": "",
            "CODE_SIGNING_REQUIRED": "NO"
        ]

        if let packageName = projectOption?.packageName {
            baseSettings.updateValue("\(packageName)",
                                     forKey: "SWIFT_PACKAGE_NAME")
        }

        let settings = Settings.settings(
            base: baseSettings,
            configurations: [
                .debug(name: .dev, xcconfig: .moduleXCConfig(type: .dev)),
                .debug(name: .test, xcconfig: .moduleXCConfig(type: .test)),
                .release(name: .qa, xcconfig: .moduleXCConfig(type: .qa)),
                .release(name: .stage, xcconfig: .moduleXCConfig(type: .stage)),
                .release(name: .prod, xcconfig: .moduleXCConfig(type: .prod))
            ]
        )

        let unitTestTargetName = "\(name)Tests"
        let demoAppTargetName = "\(name)DemoApp"
        let unitTestBundleId = "kr.minsone.\(unitTestTargetName)"

        for targetConfig in targetConfigurations {
            let target = ProjectDescription
                .Target.target(name: targetConfig.name,
                               destinations: .iOS,
                               product: .staticLibrary,
                               bundleId: "kr.minsone.\(targetConfig.name)",
                               sources: ["Sources/\(targetConfig.folderName)/**"],
                               dependencies: targetConfig.dependencies)
            targets.append(target)

            let scheme = Scheme.makeScheme(
                name: targetConfig.name,
                unitTestTargetName: unitTestTargetName,
                configuration: .dev,
                hidden: true
            )
            schemes.append(scheme)
        }

        let allTargetDependencies: [TargetDependency] = targetConfigurations.map {
            .target(name: $0.name)
        }

        if target.hasUnitTest {
            let unitTestTarget = ProjectDescription.Target
                .target(name: unitTestTargetName,
                        destinations: .iOS,
                        product: .unitTests,
                        bundleId: unitTestBundleId,
                        deploymentTargets: deploymentTarget,
                        infoPlist: .default,
                        sources: "Tests/**",
                        dependencies: allTargetDependencies)
            targets.append(unitTestTarget)
        }

        if target.hasDemoApp {
            let demoAppTarget = ProjectDescription.Target
                .target(
                    name: demoAppTargetName,
                    destinations: .iOS,
                    product: .app,
                    bundleId: Misc.defaultDemoAppBundleId,
                    deploymentTargets: deploymentTarget,
                    infoPlist: .default,
                    sources: "App/DemoApp/Sources/**",
                    resources: "App/DemoApp/Resources/**",
                    dependencies: allTargetDependencies,
                    settings: settings
                )
            targets.append(demoAppTarget)
        }

        project = Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes,
            additionalFiles: [
                .glob(pattern: "README.md"),
                .glob(pattern: "Project.swift")
            ]
        )
    }
}

private extension Scheme {
    static func makeScheme(name: String,
                           unitTestTargetName: String,
                           configuration: ConfigurationName,
                           hidden: Bool = true) -> Self
    {
        .scheme(name: name,
                shared: true,
                hidden: hidden,
                buildAction: .buildAction(targets: [.target(name)]),
                testAction: .targets(["\(unitTestTargetName)"],
                                     arguments: nil,
                                     configuration: configuration,
                                     options: .options(coverage: true)),
                runAction: .runAction(configuration: configuration),
                archiveAction: .archiveAction(configuration: configuration),
                profileAction: .profileAction(configuration: configuration),
                analyzeAction: .analyzeAction(configuration: configuration))
    }
}
