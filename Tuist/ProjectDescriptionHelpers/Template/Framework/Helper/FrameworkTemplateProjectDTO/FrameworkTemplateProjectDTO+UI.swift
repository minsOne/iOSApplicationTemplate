import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO {
    struct UI {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasInternalDTO: Bool
            let targets: [FrameworkTemplate.Target.UI]
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let uiDependencies: [TargetDependency]
            let previewDependencies: [TargetDependency]
        }

        private(set) var targets: [Target] = []
        private(set) var schemes: [Scheme] = []

        init?(info: Info) {
            guard
                info.targets.contains(where: \.hasUI)
            else {
                return nil
            }

            let hasUIPreview = info.targets.contains(where: \.hasPreview)

            Module(
                info: .init(
                    name: info.name,
                    hasInternalDTO: info.hasInternalDTO,
                    destinations: info.destinations,
                    deploymentTargets: info.deploymentTargets,
                    uiDependencies: info.uiDependencies
                ))
                |> { update(target: $0.target, scheme: $0.scheme) }

            (hasUIPreview
                ?> Preview(
                    info: .init(
                        name: info.name,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        previewDependencies: info.previewDependencies
                    )
                ))
                ||> { update(target: $0.target, scheme: $0.scheme) }
        }

        private mutating func update(target: Target? = nil, scheme: Scheme? = nil) {
            target.map { targets.append($0) }
            scheme.map { schemes.append($0) }
        }
    }
}

private extension FrameworkTemplateProjectDTO.UI {
    struct Module {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasInternalDTO: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
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
                dependencies: dependencies
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
                dependencies: dependencies
            )
            target = preview.target
            scheme = preview.scheme
        }
    }
}
