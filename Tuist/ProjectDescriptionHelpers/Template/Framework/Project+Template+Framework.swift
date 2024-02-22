import Foundation
import ProjectDescription

public extension Project {
    static func framework(name: String,
                          destinations: Destinations = .iOS,
                          deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                          target: [FrameworkTemplate.Target] = [],
                          packages: [Package] = [],
                          dependencies: [TargetDependency] = [],
                          uiDependencies: [TargetDependency] = [],
                          configure: FrameworkTemplate.TargetConfigure = .init()) -> Self {
        var targets: [Target] = []
        var schemes: [Scheme] = []

        let name = Name(name)

        let module_macho = target.module
        let hasModule = module_macho != nil
        let hasUI = target.hasUI
        let hasInternalDTO = target.hasInternalDTO

        func makeFrameworkTargets() {
            // Framework
            guard hasModule else {
                return
            }

            let hasTesting = target.hasTesting
            let hasDemoApp = target.hasDemoApp
            let hasUnitTests = target.hasUnitTests

            if let module_macho {
                let macho: Generator.MachO = switch module_macho {
                case .dynamic: .dynamic
                case .static: .static
                }
                let isHiddenScheme = configure.framework.module.isHiddenScheme
                let unitTestsName = hasUnitTests ? name.framework.unitTests : nil
                var dependencies = dependencies
                if hasUI {
                    dependencies.append(.target(name: name.ui.module))
                }
                if hasInternalDTO {
                    dependencies.append(.target(name: name.internalDTO))
                }

                let (target, scheme) =
                    Generator.frameworkModule(name: name.framework.module,
                                              macho: macho,
                                              destinations: destinations,
                                              deploymentTargets: deploymentTargets,
                                              dependencies: dependencies,
                                              hiddenScheme: isHiddenScheme,
                                              unitTestsName: unitTestsName)
                targets.append(target)
                schemes.append(scheme)
            }

            if hasTesting {
                var dependencies = configure.framework.testing.dependency
                dependencies.append(.target(name: name.framework.module))

                let (target, scheme) =
                    Generator.frameworkTesting(name: name.framework.testing,
                                               destinations: destinations,
                                               deploymentTargets: deploymentTargets,
                                               dependencies: dependencies)
                targets.append(target)
                schemes.append(scheme)
            }

            if hasDemoApp {
                let demoAppConfigure = configure.framework.demoApp
                var dependencies = demoAppConfigure.dependency
                dependencies += hasTesting
                    ? [.target(name: name.framework.testing)]
                    : [.target(name: name.framework.module)]
                let bundleId = demoAppConfigure.bundleId
                let unitTestsName = hasUnitTests ? name.framework.unitTests : nil
                let infoPlist: [String: Plist.Value] = [
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen",
                ]

                let (target, scheme) =
                    Generator.frameworkDemoApp(name: name.framework.demoApp,
                                               destinations: destinations,
                                               deploymentTargets: deploymentTargets,
                                               infoPlist: infoPlist,
                                               dependencies: dependencies,
                                               bundleId: bundleId,
                                               unitTestName: unitTestsName)

                targets.append(target)
                schemes.append(scheme)
            }

            if hasUnitTests {
                var dependencies = configure.framework.testing.dependency
                dependencies += hasTesting
                    ? [.target(name: name.framework.testing)]
                    : [.target(name: name.framework.module)]

                let target =
                    Generator.frameworkUnitTests(name: name.framework.unitTests,
                                                 destinations: destinations,
                                                 deploymentTargets: deploymentTargets,
                                                 dependencies: dependencies)
                targets.append(target)
            }
        }

        func makeUITargets() {
            guard hasUI else {
                return
            }

            let hasUIPreview = target.hasUIPreview

            do {
                var dependencies = uiDependencies
                if hasInternalDTO {
                    dependencies.append(.target(name: name.internalDTO))
                }

                let (target, scheme) =
                    Generator.uiModule(name: name.ui.module,
                                       destinations: destinations,
                                       deploymentTargets: deploymentTargets,
                                       dependencies: dependencies)
                targets.append(target)
                schemes.append(scheme)
            }

            if hasUIPreview {
                let dependencies = configure.ui.preview.dependency + [.target(name: name.ui.module)]

                let (target, scheme) =
                    Generator.uiPreview(name: name.ui.preview,
                                        destinations: destinations,
                                        deploymentTargets: deploymentTargets,
                                        dependencies: dependencies)
                targets.append(target)
                schemes.append(scheme)
            }
        }

        func makeInternalDTOTarget() {
            guard hasInternalDTO else {
                return
            }

            let (target, scheme) =
                Generator.internalDTOTarget(name: name.internalDTO,
                                            destinations: destinations,
                                            deploymentTargets: deploymentTargets,
                                            dependencies: [])
            targets.append(target)
            schemes.append(scheme)
        }

        makeFrameworkTargets()
        makeUITargets()
        makeInternalDTOTarget()

        return Generator.project(name: name.project,
                                 packages: packages,
                                 targets: targets,
                                 schemes: schemes)
    }
}

// MARK: generate Framework Target

private extension Project {
    enum Generator {
        enum MachO {
            case `static`, dynamic
        }
    }
}

private extension Project.Generator {
    static func frameworkModule(name: String,
                                macho: MachO,
                                destinations: Destinations = .iOS,
                                deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                                infoPlist: [String: Plist.Value] = [:],
                                dependencies: [TargetDependency] = [],
                                hiddenScheme: Bool = false,
                                unitTestsName: String? = nil) -> (Target, Scheme) {
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
                                   settings: nil)

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
                                 dependencies: [TargetDependency] = []) -> (Target, Scheme) {
        let bundleId = BundleIdGenerator().generate(name: name)
        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Testing/**"],
                                   dependencies: dependencies,
                                   settings: nil)

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
                                 unitTestName: String? = nil) -> (Target, Scheme) {
        let bundleId = bundleId ?? BundleIdGenerator().defaultDemoAppBundleId
        var testAction: TestAction?
        if let unitTestName {
            testAction = .targets(["\(unitTestName)"],
                                  configuration: .dev,
                                  options: .options(coverage: true))
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
                                   settings: nil,
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
                                   dependencies: [TargetDependency] = []) -> Target {
        let bundleId = BundleIdGenerator().generate(name: name)

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .unitTests,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .default,
                                   sources: ["Tests/UnitTests/**"],
                                   dependencies: dependencies)

        return target
    }
}

// MARK: Generator UI Target

private extension Project.Generator {
    static func uiModule(name: String,
                         destinations: Destinations = .iOS,
                         deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                         infoPlist: [String: Plist.Value] = [:],
                         dependencies: [TargetDependency] = []) -> (Target, Scheme) {
        let bundleId = BundleIdGenerator().generate(name: name)

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Sources/UI/**"],
                                   dependencies: dependencies,
                                   settings: nil)
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
                          dependencies: [TargetDependency] = []) -> (Target, Scheme) {
        let bundleId = BundleIdGenerator().generate(name: name)

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .framework,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["UIPreview/**"],
                                   dependencies: dependencies,
                                   settings: nil)
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

private extension Project.Generator {
    static func internalDTOTarget(name: String,
                                  destinations: Destinations = .iOS,
                                  deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                                  dependencies: [TargetDependency] = []) -> (Target, Scheme) {
        let bundleId = BundleIdGenerator().generate(name: name)

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .default,
                                   sources: ["Sources/InternalDTO/**"],
                                   settings: nil)
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

private extension Project.Generator {
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
            additionalFiles: []
        )

        return project
    }
}

private struct Name {
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
