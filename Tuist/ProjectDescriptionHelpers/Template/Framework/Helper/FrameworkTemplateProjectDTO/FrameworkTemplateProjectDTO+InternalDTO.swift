import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO {
    struct InternalDTO {
        struct Info {
            let name: FrameworkTemplateTargetNameSet
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let internalDTO = Generator.InternalDTO(
                name: info.name.internalDTO,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets
            )

            target = internalDTO.target
            scheme = internalDTO.scheme
        }
    }
}
