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
    struct TargetInfo {
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
        let isEnableTest: Bool

        public init(isEnableTest: Bool) {
            self.isEnableTest = isEnableTest
        }
    }
}

public extension MultipleTargetTemplate {
    init(name: String,
         organizationName: String = "minsone",
         packages: [Package] = [],
         product: Product,
         platform: Platform = .iOS,
         deploymentTarget: DeploymentTargets? = FrameworkTemplate.DefaultValue.deploymentTargets,
         targetInfos: [TargetInfo],
         projectOption: ProjectOption? = nil)
    {
        var targets: [Target] = []
        var schemes: [Scheme] = []

        let settings = Settings.settings(
            base: ["CODE_SIGN_IDENTITY": "",
                   "CODE_SIGNING_REQUIRED": "NO"],
            configurations: [
                .debug(name: .dev, xcconfig: .moduleXCConfig(type: .dev)),
                .debug(name: .test, xcconfig: .moduleXCConfig(type: .test)),
                .release(name: .qa, xcconfig: .moduleXCConfig(type: .qa)),
                .release(name: .stage, xcconfig: .moduleXCConfig(type: .stage)),
                .release(name: .prod, xcconfig: .moduleXCConfig(type: .prod))
            ]
        )

        let unitTestTargetName = "\(name)Tests"

        for targetInfo in targetInfos {
            let target = Target.target(name: targetInfo.name,
                                       destinations: .iOS,
                                       product: .staticLibrary,
                                       bundleId: "kr.minsone.\(targetInfo.name)",
                                       sources: ["Sources/\(targetInfo.folderName)/**"],
                                       dependencies: targetInfo.dependencies)
            targets.append(target)

            let scheme = Scheme.makeScheme(
                name: targetInfo.name,
                unitTestTargetName: unitTestTargetName,
                configuration: .dev,
                hidden: true
            )
            schemes.append(scheme)
        }

        if projectOption?.isEnableTest != false {
            let unitTestDependencies: [TargetDependency] = targets.map { .target(name: $0.name) }
            let unitTestTarget = Target.target(name: unitTestTargetName,
                                               destinations: .iOS,
                                               product: .unitTests,
                                               bundleId: "kr.minsone.\(name)Tests",
                                               deploymentTargets: deploymentTarget,
                                               infoPlist: .default,
                                               sources: "Tests/**",
                                               dependencies: unitTestDependencies)
            targets.append(unitTestTarget)
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
