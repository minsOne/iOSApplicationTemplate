import Foundation
import ProjectDescription

// MARK: generate Framework Target

extension Project {
    enum Generator {
        enum MachO {
            case `static`, dynamic
        }
    }
}

extension Project.Generator {
    static func frameworkModule(name: String,
                                macho: MachO,
                                destinations: Destinations = .iOS,
                                deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                                infoPlist: [String: Plist.Value] = [:],
                                dependencies: [TargetDependency] = [],
                                hiddenScheme: Bool = false,
                                unitTestsName: String? = nil,
                                packageName: String? = nil) -> (Target, Scheme) {
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

        var baseSettings = SettingsDictionary()
        do {
            var otherSwiftFlags = ["$(inherited)"]
            packageName.map { otherSwiftFlags.append("-package-name \($0)") }
            baseSettings["OTHER_SWIFT_FLAGS"] = .array(otherSwiftFlags)
        }

        let bundleId = BundleIdGenerator().generate(name: name)
        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: product,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Sources/Framework/**"],
                                   resources: resources,
                                   dependencies: dependencies,
                                   settings: .settings(base: baseSettings))

        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: hiddenScheme,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: testAction,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }

    static func frameworkTesting(name: String,
                                 destinations: Destinations = .iOS,
                                 deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                                 infoPlist: [String: Plist.Value] = [:],
                                 dependencies: [TargetDependency] = [],
                                 packageName: String? = nil) -> (Target, Scheme) {
        let bundleId = BundleIdGenerator().generate(name: name)

        var baseSettings = SettingsDictionary()
        do {
            let otherSwiftFlags = ["$(inherited)"]
            baseSettings["OTHER_SWIFT_FLAGS"] = .array(otherSwiftFlags)
        }

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Testing/**"],
                                   dependencies: dependencies,
                                   settings: .settings(base: baseSettings))

        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }

    static func frameworkDemoApp(name: String,
                                 destinations: Destinations = .iOS,
                                 deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                                 infoPlist: [String: Plist.Value] = [:],
                                 dependencies: [TargetDependency] = [],
                                 bundleId: String? = nil,
                                 environmentVariables: [String: EnvironmentVariable] = [:],
                                 launchArguments: [LaunchArgument] = [],
                                 unitTestName: String? = nil,
                                 packageName: String? = nil) -> (Target, Scheme) {
        let bundleId = bundleId ?? BundleIdGenerator().defaultDemoAppBundleId
        var testAction: TestAction?
        if let unitTestName {
            testAction = .targets(["\(unitTestName)"],
                                  configuration: .dev,
                                  options: .options(coverage: true))
        }

        var baseSettings = SettingsDictionary()
        do {
            let otherSwiftFlags = ["$(inherited)"]
            baseSettings["OTHER_SWIFT_FLAGS"] = .array(otherSwiftFlags)
        }

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .app,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["App/DemoApp/Sources/**"],
                                   resources: ["App/DemoApp/Resources/**"],
                                   dependencies: dependencies,
                                   settings: .settings(base: baseSettings),
                                   environmentVariables: environmentVariables,
                                   launchArguments: launchArguments)

        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: testAction,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }

    static func frameworkUnitTests(name: String,
                                   destinations: Destinations = .iOS,
                                   deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                                   infoPlist: [String: Plist.Value] = [:],
                                   dependencies: [TargetDependency] = [],
                                   packageName: String? = nil) -> Target {
        let bundleId = BundleIdGenerator().generate(name: name)

        var baseSettings = SettingsDictionary()
        do {
            let otherSwiftFlags = ["$(inherited)"]
            baseSettings["OTHER_SWIFT_FLAGS"] = .array(otherSwiftFlags)
        }

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .unitTests,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .default,
                                   sources: ["Tests/UnitTests/**"],
                                   dependencies: dependencies,
                                   settings: .settings(base: baseSettings))

        return target
    }
}

// MARK: Generator UI Target

extension Project.Generator {
    static func uiModule(name: String,
                         destinations: Destinations = .iOS,
                         deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                         infoPlist: [String: Plist.Value] = [:],
                         dependencies: [TargetDependency] = [],
                         packageName: String? = nil) -> (Target, Scheme) {
        let bundleId = BundleIdGenerator().generate(name: name)

        var baseSettings = SettingsDictionary()
        do {
            var otherSwiftFlags = ["$(inherited)"]
            packageName.map { otherSwiftFlags.append("-package-name \($0)") }
            baseSettings["OTHER_SWIFT_FLAGS"] = .array(otherSwiftFlags)
        }

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Sources/UI/**"],
                                   dependencies: dependencies,
                                   settings: .settings(base: baseSettings))
        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: nil,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }

    static func uiPreview(name: String,
                          destinations: Destinations = .iOS,
                          deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                          infoPlist: [String: Plist.Value] = [:],
                          dependencies: [TargetDependency] = [],
                          packageName: String? = nil) -> (Target, Scheme) {
        let bundleId = BundleIdGenerator().generate(name: name)

        var baseSettings = SettingsDictionary()
        do {
            let otherSwiftFlags = ["$(inherited)"]
            baseSettings["OTHER_SWIFT_FLAGS"] = .array(otherSwiftFlags)
        }

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .framework,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["UIPreview/**"],
                                   dependencies: dependencies,
                                   settings: .settings(base: baseSettings))
        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: nil,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }
}

// MARK: Generator InternalDTO Target

extension Project.Generator {
    static func internalDTOTarget(name: String,
                                  destinations: Destinations = .iOS,
                                  deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                                  dependencies: [TargetDependency] = [],
                                  packageName: String? = nil) -> (Target, Scheme) {
        let bundleId = BundleIdGenerator().generate(name: name)

        var baseSettings = SettingsDictionary()
        do {
            var otherSwiftFlags = ["$(inherited)"]
            packageName.map { otherSwiftFlags.append("-package-name \($0)") }
            baseSettings["OTHER_SWIFT_FLAGS"] = .array(otherSwiftFlags)
        }

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .default,
                                   sources: ["Sources/InternalDTO/**"],
                                   settings: .settings(base: baseSettings))
        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: nil,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }
}

extension Project.Generator {
    static func project(name: String,
                        packages: [Package] = [],
                        targets: [Target],
                        schemes: [Scheme]) -> Project {
        let project = Project(
            name: name,
            organizationName: AppInfo.organizationName,
            options: .options(
                automaticSchemesOptions: .disabled,
                disableBundleAccessors: true,
                disableShowEnvironmentVarsInScriptPhases: true,
                disableSynthesizedResourceAccessors: true
            ),
            packages: packages,
            settings: .settings(
                base: [
                    "CODE_SIGN_IDENTITY": "",
                    "CODE_SIGNING_REQUIRED": "NO",
                ],
                configurations: [
                    .debug(name: .dev, xcconfig: .moduleXCConfig(type: .dev)),
                    .debug(name: .test, xcconfig: .moduleXCConfig(type: .test)),
                    .release(name: .stage, xcconfig: .moduleXCConfig(type: .stage)),
                    .release(name: .prod, xcconfig: .moduleXCConfig(type: .prod)),
                ]
            ),
            targets: targets,
            schemes: schemes,
            fileHeaderTemplate: nil,
            additionalFiles: [
                .glob(pattern: "README.md"),
            ]
        )

        return project
    }
}

struct Name {
    struct Framework {
        let module: String
        let testing: String
        let demoApp: String
        let unitTests: String
    }

    struct UI {
        let module: String
        let preview: String
    }

    let framework: Framework
    let ui: UI
    let internalDTO: String
    let project: String

    init(_ name: String) {
        framework = .init(
            module: name,
            testing: "\(name)Testing",
            demoApp: "\(name)DemoApp",
            unitTests: "\(name)UnitTests"
        )
        ui = .init(
            module: "\(name)UI",
            preview: "\(name)UIPreview"
        )
        internalDTO = "\(name)InternalDTO"
        project = name
    }
}
