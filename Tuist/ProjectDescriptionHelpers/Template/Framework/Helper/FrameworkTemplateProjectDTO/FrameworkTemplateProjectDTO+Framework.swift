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
            let needResources: Bool
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
                    dependencies: info.dependencies, 
                    needResources: info.needResources
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
