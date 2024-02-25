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
        var targetList: [Target] = []
        var schemeList: [Scheme] = []

        let name = FrameworkTemplateTargetName(name)
        let hasUI = target.hasUI
        let hasInternalDTO = target.hasInternalDTO
        let packageName = configure.framework.module.packageName

        let framework = FrameworkTemplateProjectGenerator.Framework(
            info: .init(
                name: name,
                hasInternalDTO: hasInternalDTO,
                hasUI: hasUI,
                target: target,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                packageName: packageName,
                configure: configure,
                dependencies: dependencies
            )
        )

        if let framework {
            targetList.append(contentsOf: framework.targets)
            schemeList.append(contentsOf: framework.schemes)
        }

        if hasUI {
            let (targets, schemes) = makeUITargets(
                name: name,
                hasInternalDTO: hasInternalDTO,
                hasUIPreview: target.hasUIPreview,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                packageName: packageName,
                uiDependencies: uiDependencies,
                previewDependencies: configure.ui.preview.dependency
            )
            targetList.append(contentsOf: targets)
            schemeList.append(contentsOf: schemes)
        }

        if hasInternalDTO {
            let (target, scheme) = makeInternalDTOTarget(
                name: name,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                packageName: packageName
            )
            targetList.append(target)
            schemeList.append(scheme)
        }

        return FrameworkTemplateTargetSchemeGenerator
            .Project(name: name.project,
                     packages: packages,
                     targets: targetList,
                     schemes: schemeList)
            .project
    }
}

// MARK: Framework

private struct FrameworkTemplateProjectGenerator {}

private extension FrameworkTemplateProjectGenerator {
    struct Framework {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasInternalDTO: Bool
            let hasUI: Bool
            let target: [FrameworkTemplate.Target]
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
            let configure: FrameworkTemplate.TargetConfigure
            let dependencies: [TargetDependency]
        }

        let targets: [Target]
        let schemes: [Scheme]

        init?(info: Info) {
            guard let macho = info.target.module else {
                return nil
            }

            var targets: [Target] = []
            var schemes: [Scheme] = []

            let hasTesting = info.target.hasTesting
            let hasDemoApp = info.target.hasDemoApp
            let hasUnitTests = info.target.hasUnitTests

            do {
                let module = Module(
                    info: .init(
                        name: info.name,
                        macho: macho,
                        hasUnitTests: hasUnitTests,
                        hasInternalDTO: info.hasInternalDTO,
                        hasUI: info.hasUI,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        packageName: info.packageName,
                        configure: info.configure,
                        dependencies: info.dependencies
                    )
                )
                targets.append(module.target)
                schemes.append(module.scheme)
            }

            if hasTesting {
                let testing = Testing(
                    info: .init(
                        name: info.name,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        packageName: info.packageName,
                        configure: info.configure
                    )
                )
                targets.append(testing.target)
                schemes.append(testing.scheme)
            }

            if hasDemoApp {
                let demoApp = DemoApp(
                    info: .init(
                        name: info.name,
                        hasTesting: hasTesting,
                        hasUnitTests: hasUnitTests,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        packageName: info.packageName,
                        configure: info.configure
                    )
                )
                targets.append(demoApp.target)
                schemes.append(demoApp.scheme)
            }

            if hasUnitTests {
                let unitTests = UnitTests(
                    info: .init(
                        name: info.name,
                        hasTesting: hasTesting,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        packageName: info.packageName,
                        configure: info.configure
                    )
                )
                targets.append(unitTests.target)
            }

            self.targets = targets
            self.schemes = schemes
        }
    }
}

private extension FrameworkTemplateProjectGenerator.Framework {
    typealias Generator = FrameworkTemplateTargetSchemeGenerator

    struct Module {
        struct Info {
            let name: FrameworkTemplateTargetName
            let macho: FrameworkTemplate.Target.Framework.MachO
            let hasUnitTests: Bool
            let hasInternalDTO: Bool
            let hasUI: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
            let configure: FrameworkTemplate.TargetConfigure
            let dependencies: [TargetDependency]
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let macho: Generator.Framework.MachO = switch info.macho {
            case .dynamic: .dynamic
            case .static: .static
            }
            let isHiddenScheme = info.configure.framework.module.isHiddenScheme
            let unitTestsName = info.hasUnitTests ? info.name.framework.unitTests : nil
            var dependencies = info.dependencies
            if info.hasUI {
                dependencies.append(.target(name: info.name.ui.module))
            }
            if info.hasInternalDTO {
                dependencies.append(.target(name: info.name.internalDTO))
            }

            let module = Generator.Framework.Module(
                name: info.name.framework.module,
                macho: macho,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: dependencies,
                hiddenScheme: isHiddenScheme,
                unitTestsName: unitTestsName,
                packageName: info.packageName
            )
            scheme = module.scheme
            target = module.target
        }
    }

    struct Testing {
        struct Info {
            let name: FrameworkTemplateTargetName
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
            let configure: FrameworkTemplate.TargetConfigure
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            var dependencies = info.configure.framework.testing.dependency
            dependencies.append(.target(name: info.name.framework.module))

            let testing = Generator.Framework.Testing(
                name: info.name.framework.testing,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: dependencies,
                packageName: info.packageName
            )
            target = testing.target
            scheme = testing.scheme
        }
    }

    struct DemoApp {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasTesting: Bool
            let hasUnitTests: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
            let configure: FrameworkTemplate.TargetConfigure
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let demoAppConfigure = info.configure.framework.demoApp
            var dependencies = demoAppConfigure.dependency
            dependencies += info.hasTesting
                ? [.target(name: info.name.framework.testing)]
                : [.target(name: info.name.framework.module)]
            let bundleId = demoAppConfigure.bundleId
            let unitTestsName = info.hasUnitTests ? info.name.framework.unitTests : nil
            let infoPlist: [String: Plist.Value] = [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
            ]

            let demoApp = Generator.Framework.DemoApp(
                name: info.name.framework.demoApp,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                infoPlist: infoPlist,
                dependencies: dependencies,
                bundleId: bundleId,
                unitTestName: unitTestsName,
                packageName: info.packageName
            )
            target = demoApp.target
            scheme = demoApp.scheme
        }
    }

    struct UnitTests {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasTesting: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
            let configure: FrameworkTemplate.TargetConfigure
        }

        let target: Target
        init(info: Info) {
            var dependencies = info.configure.framework.testing.dependency
            dependencies += info.hasTesting
                ? [.target(name: info.name.framework.testing)]
                : [.target(name: info.name.framework.module)]

            let unitTests = Generator.Framework.UnitTests(
                name: info.name.framework.unitTests,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: dependencies,
                packageName: info.packageName
            )
            target = unitTests.target
        }
    }
}

// MARK: UI

private extension Project {
    static func makeUITargets(name: FrameworkTemplateTargetName,
                              hasInternalDTO: Bool,
                              hasUIPreview: Bool,
                              destinations: Destinations,
                              deploymentTargets: DeploymentTargets,
                              packageName: String?,
                              uiDependencies: [TargetDependency],
                              previewDependencies: [TargetDependency]) -> ([Target], [Scheme]) {
        typealias Generator = FrameworkTemplateTargetSchemeGenerator
        var targets: [Target] = []
        var schemes: [Scheme] = []

        func makeUIModule() {
            var dependencies = uiDependencies
            if hasInternalDTO {
                dependencies.append(.target(name: name.internalDTO))
            }

            let ui = Generator.UI.UIModule(name: name.ui.module,
                                           destinations: destinations,
                                           deploymentTargets: deploymentTargets,
                                           dependencies: dependencies,
                                           packageName: packageName)
            targets.append(ui.target)
            schemes.append(ui.scheme)
        }

        func makeUIPreview() {
            let dependencies = previewDependencies + [.target(name: name.ui.module)]

            let preview = Generator.UI.UIPreview(name: name.ui.preview,
                                                 destinations: destinations,
                                                 deploymentTargets: deploymentTargets,
                                                 dependencies: dependencies,
                                                 packageName: packageName)
            targets.append(preview.target)
            schemes.append(preview.scheme)
        }

        makeUIModule()

        if hasUIPreview {
            makeUIPreview()
        }

        return (targets, schemes)
    }
}

// MARK: InternalDTO

private extension Project {
    static func makeInternalDTOTarget(name: FrameworkTemplateTargetName,
                                      destinations: Destinations,
                                      deploymentTargets: DeploymentTargets,
                                      packageName: String?) -> (Target, Scheme) {
        typealias Generator = FrameworkTemplateTargetSchemeGenerator

        let internalDTO = Generator.InternalDTO(name: name.internalDTO,
                                                destinations: destinations,
                                                deploymentTargets: deploymentTargets,
                                                packageName: packageName)

        return (internalDTO.target, internalDTO.scheme)
    }
}
