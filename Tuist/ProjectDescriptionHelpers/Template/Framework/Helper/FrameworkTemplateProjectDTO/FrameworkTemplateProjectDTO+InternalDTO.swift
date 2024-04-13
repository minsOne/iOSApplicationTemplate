import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO {
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
