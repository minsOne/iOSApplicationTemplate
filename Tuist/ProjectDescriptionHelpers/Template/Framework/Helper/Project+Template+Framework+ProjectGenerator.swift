import Foundation
import ProjectDescription

// MARK: - Framework

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

struct FrameworkTemplateProjectGenerator {}

extension FrameworkTemplateProjectGenerator {
    struct Framework {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasInternalDTO: Bool
            let hasUI: Bool
            let targets: [FrameworkTemplate.Target.Framework]
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let configure: FrameworkTemplate.TargetConfigure
            let dependencies: [TargetDependency]
        }

        let targets: [Target]
        let schemes: [Scheme]

        init?(info: Info) {
            guard let macho = info.targets.module else {
                return nil
            }

            var targets: [Target] = []
            var schemes: [Scheme] = []

            let hasTesting = info.targets.hasTesting
            let hasDemoApp = info.targets.hasDemoApp
            let hasUnitTests = info.targets.hasUnitTests

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
    struct Module {
        struct Info {
            let name: FrameworkTemplateTargetName
            let macho: FrameworkTemplate.Target.Framework.MachO
            let hasUnitTests: Bool
            let hasInternalDTO: Bool
            let hasUI: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
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
                unitTestsName: unitTestsName
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
                dependencies: dependencies
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
                unitTestName: unitTestsName
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
                dependencies: dependencies
            )
            target = unitTests.target
        }
    }
}

// MARK: - UI

extension FrameworkTemplateProjectGenerator {
    struct UI {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasInternalDTO: Bool
            let targets: [FrameworkTemplate.Target.UI]
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
            let uiDependencies: [TargetDependency]
            let previewDependencies: [TargetDependency]
        }

        let targets: [Target]
        let schemes: [Scheme]

        init?(info: Info) {
            guard
                info.targets.contains(where: \.hasUI)
            else {
                return nil
            }

            let hasUIPreview = info.targets.contains(where: \.hasPreview)
            var targets: [Target] = []
            var schemes: [Scheme] = []

            let uiModule = Module(info: .init(name: info.name,
                                              hasInternalDTO: info.hasInternalDTO,
                                              destinations: info.destinations,
                                              deploymentTargets: info.deploymentTargets,
                                              packageName: info.packageName,
                                              uiDependencies: info.uiDependencies))
            targets.append(uiModule.target)
            schemes.append(uiModule.scheme)

            if hasUIPreview {
                let preview = Preview(info: .init(name: info.name,
                                                  destinations: info.destinations,
                                                  deploymentTargets: info.deploymentTargets,
                                                  packageName: info.packageName,
                                                  previewDependencies: info.previewDependencies))
                targets.append(preview.target)
                schemes.append(preview.scheme)
            }

            self.targets = targets
            self.schemes = schemes
        }
    }
}

private extension FrameworkTemplateProjectGenerator.UI {
    struct Module {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasInternalDTO: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
            let uiDependencies: [TargetDependency]
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            var dependencies = info.uiDependencies
            if info.hasInternalDTO {
                dependencies.append(.target(name: info.name.internalDTO))
            }

            let ui = Generator.UI.UIModule(
                name: info.name.ui.module,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: dependencies,
                packageName: info.packageName
            )
            target = ui.target
            scheme = ui.scheme
        }
    }

    struct Preview {
        struct Info {
            let name: FrameworkTemplateTargetName
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
            let previewDependencies: [TargetDependency]
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let dependencies = info.previewDependencies + [.target(name: info.name.ui.module)]

            let preview = Generator.UI.UIPreview(
                name: info.name.ui.preview,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: dependencies,
                packageName: info.packageName
            )
            target = preview.target
            scheme = preview.scheme
        }
    }
}

// MARK: - InternalDTO

extension FrameworkTemplateProjectGenerator {
    struct InternalDTO {
        struct Info {
            let name: FrameworkTemplateTargetName
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let packageName: String?
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let internalDTO = Generator.InternalDTO(
                name: info.name.internalDTO,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                packageName: info.packageName
            )

            target = internalDTO.target
            scheme = internalDTO.scheme
        }
    }
}

// MARK: - Project

extension FrameworkTemplateProjectGenerator {
    struct Project {
        struct Info {
            let name: String
            let packages: [Package]
            let targets: [Target]
            let schemes: [Scheme]
            let packageName: String?
        }

        let rawValue: ProjectDescription.Project

        init(info: Info) {
            rawValue = FrameworkTemplateTargetSchemeGenerator
                .Project(name: info.name,
                         packages: info.packages,
                         targets: info.targets,
                         schemes: info.schemes,
                         packageName: info.packageName)
                .project
        }
    }
}
