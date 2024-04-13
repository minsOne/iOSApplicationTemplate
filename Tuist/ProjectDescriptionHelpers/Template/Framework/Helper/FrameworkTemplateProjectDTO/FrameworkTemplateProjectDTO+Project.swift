import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO {
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
