import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO {
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

        private(set) var targets: [Target] = []
        private(set) var schemes: [Scheme] = []

        init?(info: Info) {
            guard let macho = info.targets.module else {
                return nil
            }

            let hasTesting = info.targets.hasTesting
            let hasDemoApp = info.targets.hasDemoApp
            let hasUnitTests = info.targets.hasUnitTests

            Module(
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
                ))
                |> { update(target: $0.target, scheme: $0.scheme) }

            (hasTesting
                ?> Testing(
                    info: .init(
                        name: info.name,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        configure: info.configure
                    )
                ))
                ||> { update(target: $0.target, scheme: $0.scheme) }

            (hasDemoApp
                ?> DemoApp(
                    info: .init(
                        name: info.name,
                        hasTesting: hasTesting,
                        hasUnitTests: hasUnitTests,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        configure: info.configure
                    )
                ))
                ||> { update(target: $0.target, scheme: $0.scheme) }

            (hasUnitTests
                ?> UnitTests(
                    info: .init(
                        name: info.name,
                        hasTesting: hasTesting,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        configure: info.configure
                    )
                ).target)
                ||> { update(target: $0) }
        }

        private mutating func update(target: Target? = nil, scheme: Scheme? = nil) {
            target.map { targets.append($0) }
            scheme.map { schemes.append($0) }
        }
    }
}

private extension FrameworkTemplateProjectDTO.Framework {
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
