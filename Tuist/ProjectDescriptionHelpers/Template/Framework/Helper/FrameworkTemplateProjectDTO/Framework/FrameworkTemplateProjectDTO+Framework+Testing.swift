import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator
private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO.Framework {
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
}