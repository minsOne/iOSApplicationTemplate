import Foundation
import ProjectDescription
import UtilityPlugin

public enum FeatureTarget: Hashable {
    case staticframework
    case dynamicframework
    case tests
    case testing
    case example

    public var hasFramework: Bool {
        switch self {
        case .dynamicframework, .staticframework: return true
        default: return false
        }
    }
    public var hasDynamicFramework: Bool { return self == .dynamicframework }

}

public extension Project {
    static func framework(name: String,
                          organizationName: String = "minsone",
                          deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "13.0", devices: .iphone),
                          targets: Set<FeatureTarget> = Set([.staticframework, .tests, .example, .testing]),
                          packages: [Package] = [],
                          dependencies: [TargetDependency] = []) -> Project {

        let hasDynamicFramework = targets.contains(.dynamicframework)

        var projectTargets: [Target] = []
        if targets.contains(where: { $0.hasFramework }) {
            let target = Target(
                name: name,
                platform: .iOS,
                product: hasDynamicFramework ? .framework : .staticFramework,
                bundleId: "kr.minsone.\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**/*.swift"],
                resources: hasDynamicFramework ? ["Resources/**"] : [],
                actions: [],
                dependencies: dependencies)

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
                resources: ["Testing/Resources/**"],
                actions: [],
                dependencies: [
                    .target(name: "\(name)"),
                    // TODO: Testing에 필요한 라이브러리 추가
                ])

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
                resources: ["Tests/Resources/**"],
                actions: [],
                dependencies: [
                    [
                        // TODO: Tests에 필요한 라이브러리 추가
                    ],
                    deps
                ].flatMap { $0 })

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

            let target = Target(
                name: "\(name)Example",
                platform: .iOS,
                product: .app,
                bundleId: "kr.minsone.example.\(name)Example",
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: [
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen",
                ]),
                sources: ["Example/Sources/**/*.swift"],
                resources: ["Example/Resources/**"],
                actions: [],
                dependencies: [
                    [
                        // TODO: Example에 필요한 라이브러리 추가
                    ],
                    deps
                ].flatMap { $0 })

            projectTargets.append(target)
        }

        return Project(
            name: name,
            organizationName: "minsone",
            packages: packages,
            targets: projectTargets,
            schemes: [
                Scheme(
                    name: name,
                    shared: true,
                    buildAction: BuildAction(targets: ["\(name)"]),
                    testAction: TestAction(targets: [
                        TestableTarget(
                            target: TargetReference(stringLiteral: "\(name)Tests"),
                            parallelizable: true)
                    ], coverage: true),
                    runAction: nil),
                targets.contains(.example)
                ? Scheme(
                    name: "\(name)Example",
                    shared: true,
                    buildAction: BuildAction(targets: ["\(name)Example"]),
                    testAction: TestAction(targets: [
                        TestableTarget(
                            target: TargetReference(stringLiteral: "\(name)Tests"),
                            parallelizable: true)
                    ], coverage: true)
                    )
                : nil
            ].compactMap { $0 })
    }
}

public extension Project {
    static func staticLibrary(name: String,
                              platform: Platform = .iOS,
                              packages: [Package] = [],
                              dependencies: [TargetDependency] = [],
                              hasDemoApp: Bool = false) -> Self {
        return project(name: name,
                       packages: packages,
                       product: .staticLibrary,
                       platform: platform,
                       dependencies: dependencies,
                       hasDemoApp: hasDemoApp)
    }
    
    static func staticFramework(name: String,
                                platform: Platform = .iOS,
                                packages: [Package] = [],
                                dependencies: [TargetDependency] = [],
                                hasDemoApp: Bool = false) -> Self {
        return project(name: name,
                       packages: packages,
                       product: .staticFramework,
                       platform: platform,
                       dependencies: dependencies,
                       hasDemoApp: hasDemoApp)
    }
    
    static func framework(name: String,
                          platform: Platform = .iOS,
                          packages: [Package] = [],
                          dependencies: [TargetDependency] = [],
                          hasDemoApp: Bool = false) -> Self {
        return project(name: name,
                       packages: packages,
                       product: .framework,
                       platform: platform,
                       dependencies: dependencies,
                       hasDemoApp: hasDemoApp)
    }
}

public extension Project {
    static func project(name: String,
                        organizationName: String = "minsone",
                        packages: [Package] = [],
                        product: Product,
                        platform: Platform = .iOS,
                        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "13.0", devices: .iphone),
                        dependencies: [TargetDependency] = [],
                        infoPlist: [String: InfoPlist.Value] = [:],
                        hasDemoApp: Bool = false) -> Project {
        
        let organizationName = "minsone"
        let settings = Settings(base: ["CODE_SIGN_IDENTITY": "",
                                       "CODE_SIGNING_REQUIRED": "NO"],
                                configurations: [
                                    .debug(name: .dev, xcconfig: .relativeToXCConfig(type: .dev, name: name)),
                                    .debug(name: .test, xcconfig: .relativeToXCConfig(type: .test, name: name)),
                                    .debug(name: .stage, xcconfig: .relativeToXCConfig(type: .stage, name: name)),
                                    .release(name: .prod, xcconfig: .relativeToXCConfig(type: .prod, name: name)),
                                ])
        
        let target1 = Target(name: name,
                             platform: platform,
                             product: product,
                             bundleId: "kr.minsone.\(name)",
                             deploymentTarget: deploymentTarget,
                             infoPlist: .extendingDefault(with: infoPlist),
                             sources: ["Sources/**"],
                             resources: ["Resources/**"],
                             dependencies: dependencies)
        
        let demoAppTarget = Target(name: "\(name)DemoApp",
                                   platform: platform,
                                   product: .app,
                                   bundleId: "kr.minsone.\(name)DemoApp",
                                   deploymentTarget: deploymentTarget,
                                   infoPlist: .extendingDefault(with: [
                                     "UIMainStoryboardFile": "",
                                     "UILaunchStoryboardName": "LaunchScreen"
                                   ]),
                                   sources: ["Demo/**"],
                                   resources: ["Demo/Resources/**"],
                                   dependencies: [
                                    .target(name: "\(name)")
                                   ])
        
        let testTargetDependencies: [TargetDependency] = hasDemoApp
            ? [.target(name: "\(name)DemoApp")]
            : [.target(name: "\(name)")]
        let testTarget = Target(name: "\(name)Tests",
                                platform: platform,
                                product: .unitTests,
                                bundleId: "kr.minsone.\(name)Tests",
                                deploymentTarget: deploymentTarget,
                                infoPlist: .default,
                                sources: "Tests/**",
                                dependencies: testTargetDependencies)
        
        
        
        
        let schemes: [Scheme] = hasDemoApp
            ? [.makeScheme(target: .dev, name: name), .makeDemoScheme(target: .dev, name: name)]
            : [.makeScheme(target: .dev, name: name)]

        let targets: [Target] = hasDemoApp
            ? [target1, testTarget, demoAppTarget]
            : [target1, testTarget]
        
        return Project(name: name,
                       organizationName: organizationName,
                       packages: packages,
                       settings: settings,
                       targets: targets,
                       schemes: schemes)
    }
}

extension Scheme {
    static func makeScheme(target: ProjectDeployTarget, name: String) -> Self {
        return Scheme(name: "\(name)",
                      shared: true,
                      buildAction: BuildAction(targets: ["\(name)"]),
                      testAction: TestAction(targets: ["\(name)Tests"],
                                             configurationName: target.rawValue,
                                             coverage: true),
                      runAction: RunAction(configurationName: target.rawValue),
                      archiveAction: ArchiveAction(configurationName: target.rawValue),
                      profileAction: ProfileAction(configurationName: target.rawValue),
                      analyzeAction: AnalyzeAction(configurationName: target.rawValue))
    }

    static func makeDemoScheme(target: ProjectDeployTarget, name: String) -> Self {
        return Scheme(name: "\(name)DemoApp",
                      shared: true,
                      buildAction: BuildAction(targets: ["\(name)DemoApp"]),
                      testAction: TestAction(targets: ["\(name)Tests"],
                                             configurationName: target.rawValue,
                                             coverage: true),
                      runAction: RunAction(configurationName: target.rawValue),
                      archiveAction: ArchiveAction(configurationName: target.rawValue),
                      profileAction: ProfileAction(configurationName: target.rawValue),
                      analyzeAction: AnalyzeAction(configurationName: target.rawValue))
    }
}
