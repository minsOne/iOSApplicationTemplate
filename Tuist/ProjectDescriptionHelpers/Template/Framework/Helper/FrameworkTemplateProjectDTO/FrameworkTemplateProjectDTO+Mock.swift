import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO {
    struct Mock {
        struct Info {
            let name: FrameworkTemplateTargetName
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let dependencies: [TargetDependency]
        }
        
        private(set) var targets: [Target] = []
        private(set) var schemes: [Scheme] = []
        
        init(info: Info) {
            Generator.Mock
                .Module(name: info.name.interface)
            |> { update(target: $0.target, scheme: $0.scheme) }
        }
        
        private mutating func update(target: Target? = nil, scheme: Scheme? = nil) {
            target.map { targets.append($0) }
            scheme.map { schemes.append($0) }
        }
    }
}
