import Foundation
import ProjectDescription
import UtilityPlugin

public extension Project {
    static func framework(name: String,
                          organizationName: String = "minsone",
                          deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "13.0", devices: .iphone),
                          targets: Set<FeatureTarget> = Set([.staticLibrary, .tests, .example, .testing]),
                          packages: [Package] = [],
                          dependencies: [TargetDependency] = [],
                          testingDependencies: [TargetDependency] = [],
                          exampleTargetOption: ExampleTargetOption? = nil) -> Project {

        let hasDynamicFramework = targets.contains(.dynamicFramework)
        let configurationName: ConfigurationName = "Test"

        var projectTargets: [Target] = []
        if targets.contains(where: { $0.hasFramework }) {
            let settings: SettingsDictionary = hasDynamicFramework
            ? ["OTHER_LDFLAGS" : "$(inherited) -all_load"]
            : ["OTHER_LDFLAGS" : "$(inherited)"]

            let target = Target(
                name: name,
                platform: .iOS,
                product: hasDynamicFramework ? .framework : .staticFramework,
                bundleId: "kr.minsone.\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**/*.swift"],
                resources:  hasDynamicFramework ? [.glob(pattern: "Resources/**", excluding: ["Resources/dummy.txt"])] : [],
                dependencies: dependencies,
                settings: .settings(base: settings, configurations: XCConfig.framework)
            )

            projectTargets.append(target)
        }

        if targets.contains(.testing) {
            let target = Target(
                name: "\(name)Testing",
                platform: .iOS,
                product: .framework,
                bundleId: "kr.minsone.\(name)Testing",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Testing/Sources/**/*.swift"],
                resources: [.glob(pattern: "Testing/Resources/**", excluding: ["Testing/Resources/dummy.txt"])],
                dependencies: [
                    testingDependencies,
                    [
                        .target(name: "\(name)"),
                    ]
                ].flatMap { $0 },
                settings: .settings(base: [:], configurations: XCConfig.framework)
            )

            projectTargets.append(target)
        }

        if targets.contains(.example) {
            /// Framework의 Mach-O가 Static 또는 Dynamic인지에 따라 코드 복사 또는 링킹이 발생하여 상황에 맞게 의존관계를 추가해야함.
            let deps: [TargetDependency]
            switch (hasDynamicFramework, targets.contains(.testing)) {
            case (true, true): deps = [.target(name: name), .target(name: "\(name)Testing")]
            case (false, true): deps = [.target(name: "\(name)Testing")]
            case (_, false): deps = [.target(name: name)]
            }

            let bundleId = exampleTargetOption?.bundleId ?? "kr.minsone.example.\(name)Example"
            let target = Target(
                name: "\(name)Example",
                platform: .iOS,
                product: .app,
                bundleId: bundleId,
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: [
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "LSSupportsOpeningDocumentsInPlace": true,
                    "UIFileSharingEnabled": true,
                ]),
                sources: ["Example/Sources/**/*.swift"],
                resources: [.glob(pattern: "Example/Resources/**", excluding: ["Example/Resources/dummy.txt"])],
                dependencies: [
                    [
                        Dep.Framework.Common.RxSwift,
                        Dep.Framework.Common.RxCocoa,
                        Dep.Framework.Common.RxRelay,
                    ],
                    deps,
                    [
                        // DevTool
                        Dep.Project.DevelopTool.ExampleDevToolPackage
                    ],
                ].flatMap { $0 },
                settings: .settings(base: [:], configurations: XCConfig.example)
            )

            projectTargets.append(target)
        }

        if targets.contains(.tests) {
            /// Framework의 Mach-O가 Static 또는 Dynamic인지에 따라 코드 복사 또는 링킹이 발생하여 상황에 맞게 의존관계를 추가해야함.
            let deps: [TargetDependency]
            switch (hasDynamicFramework, targets.contains(.testing), targets.contains(.example)) {
            case (true, true, true):
                deps = [.target(name: name), .target(name: "\(name)Testing"), .target(name: "\(name)Example")]
            case (true, true, false):
                deps = [.target(name: name), .target(name: "\(name)Testing")]
            case (true, false, true):
                deps = [.target(name: name), .target(name: "\(name)Example")]
            case (false, true, true):
                deps = [.target(name: "\(name)Testing"), .target(name: "\(name)Example")]
            case (false, true, false):
                deps = [.target(name: "\(name)Testing")]
            case (false, false, true):
                deps = [.target(name: "\(name)Example")]
            case (true, false, false), (false, false, false):
                deps = [.target(name: name)]
            }

            let target = Target(
                name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "kr.minsone.\(name)Tests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: [.glob(pattern: "Tests/Resources/**", excluding: ["Tests/Resources/dummy.txt"])],
                dependencies: [
                    [
                        .xctest,
                        .Framework.Common.RxSwift,
                        .Framework.Common.RxRelay,
                        .Framework.DevelopTool.RxBlocking,
                        .Framework.DevelopTool.RxTest,
                        .Framework.DevelopTool.Nimble,
                        .Framework.DevelopTool.Quick,
                        .Framework.DevelopTool.RxNimbleRxTest,
                        .Framework.DevelopTool.RxNimbleRxBlocking,
                    ],
                    deps
                ].flatMap { $0 },
                settings: .settings(base: [:], configurations: XCConfig.tests)
            )

            projectTargets.append(target)
        }

        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: .settings(configurations: XCConfig.project),
            targets: projectTargets,
            schemes: [
                Scheme(name: name,
                       shared: true,
                       buildAction: .buildAction(targets: ["\(name)"]),
                       testAction: .targets(
                        [
                            TestableTarget(
                                target: TargetReference(stringLiteral: "\(name)Tests"),
                                parallelizable: true)
                        ],
                        configuration: configurationName,
                        options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
                       ),
                       runAction: .runAction(configuration: configurationName),
                       archiveAction: .archiveAction(configuration: configurationName),
                       profileAction: .profileAction(configuration: configurationName),
                       analyzeAction: .analyzeAction(configuration: configurationName)),
                targets.contains(.example)
                ? Scheme(
                    name: "\(name)Example",
                    shared: true,
                    buildAction: BuildAction(targets: ["\(name)Example"]),
                    testAction: .targets(
                     [
                         TestableTarget(
                             target: TargetReference(stringLiteral: "\(name)Tests"),
                             parallelizable: true)
                     ],
                     configuration: configurationName,
                     options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
                    ),
                    runAction: .runAction(configuration: configurationName),
                    archiveAction: .archiveAction(configuration: configurationName),
                    profileAction: .profileAction(configuration: configurationName),
                    analyzeAction: .analyzeAction(configuration: configurationName))
                : nil
            ].compactMap { $0 },
            additionalFiles: ["README.md"])
    }
}
