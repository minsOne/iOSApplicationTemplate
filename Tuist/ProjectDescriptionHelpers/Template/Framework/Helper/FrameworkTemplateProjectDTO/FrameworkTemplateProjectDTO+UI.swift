import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO {
    struct UI {
        struct Info {
            let name: FrameworkTemplateTargetNameSet
            let hasInternalDTO: Bool
            let targets: [FrameworkTemplate.Target.UI]
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let configure: FrameworkTemplate.TargetConfigure
        }

        private(set) var targets: [Target] = []
        private(set) var schemes: [Scheme] = []

        init?(info: Info) {
            guard
                info.targets.contains(where: \.hasUI)
            else {
                return nil
            }

            let hasUIPreview = info.targets.hasUIPreview
            let hasUIPreviewApp = info.targets.hasUIPreviewApp

            let uiPreviewDependencies = info.configure.preview.dependency + [.target(name: info.name.ui.module)]
            let uiPreviewAppDependencies = info.configure.previewApp.dependency + [.target(name: info.name.ui.uiPreview)]

            Module(
                info: .init(
                    name: info.name,
                    hasInternalDTO: info.hasInternalDTO,
                    destinations: info.destinations,
                    deploymentTargets: info.deploymentTargets,
                    uiDependencies: info.configure.ui.dependency
                ))
                |> { update(target: $0.target, scheme: $0.scheme) }

            if hasUIPreview {
                UIPreview(
                    info: .init(
                        name: info.name,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        dependencies: uiPreviewDependencies
                    )
                ) ||> { update(target: $0.target, scheme: $0.scheme) }
            }

            if hasUIPreviewApp {
                UIPreviewApp(
                    info: .init(
                        name: info.name,
                        destinations: info.destinations,
                        deploymentTargets: info.deploymentTargets,
                        dependencies: uiPreviewAppDependencies
                    )
                ) ||> { update(target: $0.target, scheme: $0.scheme) }
            }
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
            let name: FrameworkTemplateTargetNameSet
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

    struct UIPreview {
        struct Info {
            let name: FrameworkTemplateTargetNameSet
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let dependencies: [TargetDependency]
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let preview = Generator.UI.UIPreview(
                name: info.name.ui.uiPreview,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: info.dependencies
            )
            target = preview.target
            scheme = preview.scheme
        }
    }

    struct UIPreviewApp {
        struct Info {
            let name: FrameworkTemplateTargetNameSet
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let dependencies: [TargetDependency]
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let preview = Generator.UI.UIPreviewApp(
                name: info.name.ui.uiPreview,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: info.dependencies
            )
            target = preview.target
            scheme = preview.scheme
        }
    }
}
