import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO {
    struct Framework {
        struct Info {
            let name: FrameworkTemplateTargetNameSet
            let hasInterface: Bool
            let hasInternalDTO: Bool
            let hasUI: Bool
            let targets: [FrameworkTemplate.Target.Framework]
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let configure: FrameworkTemplate.TargetConfigure
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
            let hasWidgetExtension = info.targets.hasWidgetExtension

            Module(
                info: .init(name: info.name,
                            macho: macho,
                            hasInterface: info.hasInterface,
                            hasUnitTests: hasUnitTests,
                            hasInternalDTO: info.hasInternalDTO,
                            hasUI: info.hasUI,
                            destinations: info.destinations,
                            deploymentTargets: info.deploymentTargets,
                            configure: info.configure,
                            dependencies: info.configure.framework.dependency,
                            needResources: info.configure.framework.needResources))
                |> { update(target: $0.target, scheme: $0.scheme) }

            (hasTesting
                ?> Testing(
                    info: .init(name: info.name,
                                destinations: info.destinations,
                                deploymentTargets: info.deploymentTargets,
                                configure: info.configure)))
                ||> { update(target: $0.target, scheme: $0.scheme) }

            (hasDemoApp
                ?> DemoApp(
                    info: .init(name: info.name,
                                hasTesting: hasTesting,
                                hasUnitTests: hasUnitTests,
                                destinations: info.destinations,
                                deploymentTargets: info.deploymentTargets,
                                configure: info.configure)))
                ||> { update(target: $0.target, scheme: $0.scheme) }

            (hasUnitTests
                ?> UnitTests(
                    info: .init(
                        name: info.name,
                        hasTesting: hasTesting,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        configure: info.configure
                    )))
                ||> { update(target: $0.target) }

            (hasWidgetExtension
                ?> WidgetExtension(
                    info: .init(name: info.name,
                                hasDemoApp: true,
                                destinations: info.destinations,
                                deploymentTargets: .default)))
                ||> { update(target: $0.target, scheme: $0.scheme) }
        }

        private mutating func update(target: Target? = nil, scheme: Scheme? = nil) {
            target.map { targets.append($0) }
            scheme.map { schemes.append($0) }
        }
    }
}
