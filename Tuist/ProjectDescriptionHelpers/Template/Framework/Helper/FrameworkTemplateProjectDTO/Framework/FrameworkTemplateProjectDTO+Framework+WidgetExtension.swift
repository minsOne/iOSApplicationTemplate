import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator
private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO.Framework {
    struct WidgetExtension {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasDemoApp: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let dependencies: [TargetDependency] = [
                .sdk(name: "SwiftUI", type: .framework),
                .sdk(name: "WidgetKit", type: .framework),
                .target(name: info.name.framework.module),
            ]

            let name = info.name.framework.widgetExtension
            let widgetExtension = Generator.Framework
                .WidgetExtension(name: name,
                                 destinations: info.destinations,
                                 deploymentTargets: info.deploymentTargets,
                                 dependencies: dependencies)

            target = widgetExtension.target
            scheme = widgetExtension.scheme
        }
    }
}
